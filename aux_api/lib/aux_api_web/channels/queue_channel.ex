import Ecto.Query
import Ecto.Changeset
import AuxApi.AuxLibrary
alias AuxApi.Repo

defmodule AuxApiWeb.QueueChannel do
  require Logger
  use AuxApiWeb, :channel

  def join("queue:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    # sess = %AuxApi.Session{}
    # {:ok, curr_sess} = AuxApi.Repo.insert(sess)
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("add_song", payload, socket) do
    # payload: str: member_id, str: qentry_id, str: spotify_uri
    # generate previous song id by filtering for qentry where next is null (same member and queue id)
    # insert

    member_id = payload["member_id"] #2
    session_id = payload["session_id"] #2
    song_id = payload["song_id"] #"spotify:track:2G7V7zsVDxg1yRsu7Ew9RJ"

		{prev_qentry_id, _} = find_last_qentry(member_id, session_id)

    qentry = %AuxApi.Qentry{
      song_id: song_id,
      session_id: session_id,
      member_id: member_id,
      next_qentry_id: nil,
      prev_qentry_id: prev_qentry_id,
    }

    {:ok, test_qentry} = Repo.insert(qentry)

    update_next_qentry(prev_qentry_id, test_qentry.id)
    {:reply, {:ok, payload}, socket} # TODO: update with proper response
  end

	def handle_in("change_pos", payload, socket) do
		# TODO: pull member and session id from channel, or from db?
    member_id = payload["member_id"]
    session_id = payload["session_id"]
    id = payload["qentry_id"]
    new_prev_id = payload["new_prev_id"]

    # link this qentry's previous and next (== remove this qentry)
		# curr.prev.next = curr.next
		# curr.next.prev = curr.prev
		curr_prev_id = find_prev_qentry(id)
		curr_next_id = find_next_qentry(id)

		unless new_prev_id == curr_prev_id do
			update_prev_qentry(curr_next_id, curr_prev_id)
			update_next_qentry(curr_prev_id, curr_next_id)

			# curr.next = new_prev.next
			if is_nil(new_prev_id) do
				# song needs to go to front of the queue
				{new_next_id, _} = find_first_qentry(member_id, session_id)
				update_prev_qentry(new_next_id, id)
				update_next_qentry(id, new_next_id)
			else
				# song is now in the middle somewhere, or at the end
				new_next_id = find_next_qentry(new_prev_id)
				update_prev_qentry(new_next_id, id)
				update_next_qentry(id, new_next_id)
			end

			# curr.prev = new_prev
			# new_prev.next = curr
			update_prev_qentry(id, new_prev_id)
			update_next_qentry(new_prev_id, id)
    end

    {:reply, {:ok, payload}, socket} # TODO: update with proper response
	end

	def handle_in("delete_song", payload, socket) do
		# song could be: beginning, middle, end
		# this should be fine with the two linkedlists approach, no edits
		qentry_id = payload["qentry_id"]

		prev_qentry_id = find_prev_qentry(qentry_id)
		next_qentry_id = find_next_qentry(qentry_id)

		update_prev_qentry(next_qentry_id, prev_qentry_id)
		update_next_qentry(prev_qentry_id, next_qentry_id)

		from(q in "qentries", where: q.id == ^qentry_id) |> Repo.delete_all
		{:reply, {:ok, payload}, socket} # TODO: update with proper response
	end

	def handle_in("get_songs", payload, socket) do
		member_id = payload["member_id"]
		session_id = payload["session_id"]

		{qentry_id, song_id} = find_first_qentry(member_id, session_id)
		tracker = get_songs_recursive(qentry_id, [[qentry_id, song_id]])

		{:reply, {:ok, %{songs: tracker}}, socket}
	end

	def handle_in("leave_sess", payload, socket) do
		member_id = payload["member_id"]
		session_id = payload["session_id"]

		from(q in "qentries", where: q.member_id == ^member_id and q.session_id == ^session_id) |> Repo.delete_all
		{:reply, {:ok, payload}, socket} # TODO: update with proper response
	end

	def handle_in("next", %{"member_id" => mid, "session_id" => sid}, socket) do
		member = String.to_integer(mid)
		session = String.to_integer(sid)

		{qentry, _} = find_first_qentry(member, session)
		if is_nil(qentry) do
			{:reply, {:ok, %{info: "no songs in queue"}}, socket}
		else
			song_id = mark_played(member, session, qentry)
			{:reply, {:ok, %{qentry_id: qentry, song_id: song_id}}, socket}
		end
	end

	defp mark_played(member_id, session_id, qentry_id) do
		get_neighbors = from q in "qentries",
			where: (q.id == ^qentry_id),
			select: {q.prev_qentry_id, q.next_qentry_id}
		if not is_nil(qentry_id) do
			{prev, next} = List.first(Repo.all(get_neighbors))

			if not is_nil(prev) do
				from(q in "qentries", where: q.id == ^prev, update: [set: [next_qentry_id: ^next]])
        |> Repo.update_all([])
			end

			if not is_nil(next) do
				from(q in "qentries", where: q.id == ^next, update: [set: [prev_qentry_id: ^prev]])
        |> Repo.update_all([])
			end

			{last_played, _} = find_last_qentry(member_id, session_id, true)
			if not is_nil(last_played) do
				from(q in "qentries", where: q.id == ^last_played, update: [set: [next_qentry_id: ^qentry_id,]])
				|> Repo.update_all([])
			end
			from(q in "qentries", where: q.id == ^qentry_id,
				update: [
					set: [
						played: true,
						next_qentry_id: nil,
						prev_qentry_id: ^last_played,
					]])
			|> Repo.update_all([])
			# not_played = "empty"
			# if not is_nil(next) do
			# 	not_played = print_qentry_order(next, Integer.to_string(next) <> " ")
			# 	played = print_qentry_order_backwards(qentry_id, Integer.to_string(qentry_id) <> " ")
			# 	"played: " <> played <> "\nnot played: " <> not_played
			# else
			# 	played = print_qentry_order_backwards(qentry_id, Integer.to_string(qentry_id) <> " ")
			# 	song_id, "played: " <> played <> "\nnot played: " <> not_played
			# end

			get_next_song = from qentry in "qentries",
				where: (qentry.id == ^next),
				select: qentry.song_id
			song_id = List.first(Repo.all(get_next_song))
		end
  end
	# It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (queue:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
	end

  # Add authorization logic here as required.
  # on join channel
  defp authorized?(_payload) do
    # check member_id and spotify_uid pair match in DB

    true
  end
end
