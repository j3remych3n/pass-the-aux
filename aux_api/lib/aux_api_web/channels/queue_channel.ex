import Ecto.Query
import Ecto.Changeset
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
    # payload: str: member_id, str: queue_id, str: spotify_uri
    # generate previous song id by filtering for qentry where next is null (same member and queue id)
    # insert

    member_id = payload["member_id"] #2
    session_id = payload["session_id"] #2
    song_id = payload["song_id"] #"spotify:track:2G7V7zsVDxg1yRsu7Ew9RJ"

    prev_qentry_id = find_last_qentry(member_id, session_id)

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
    member_id = payload["member_id"]
    session_id = payload["session_id"]
    id = payload["queue_id"]
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
				new_next_id = find_first_qentry(member_id, session_id)
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

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (queue:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  defp find_prev_qentry(qentry_id) do
		query = from qentry in "qentries",
			where: (qentry.id == ^qentry_id),
			select: qentry.prev_qentry_id

    List.first(Repo.all(query))
  end

	defp find_next_qentry(qentry_id) do
		query = from qentry in "qentries",
			where: (qentry.id == ^qentry_id),
      select: qentry.next_qentry_id

		List.first(Repo.all(query))
  end

  defp update_prev_qentry(qentry_id, prev_id) do
		if not is_nil(qentry_id) do
			from(q in "qentries", where: q.id == ^qentry_id, update: [set: [prev_qentry_id: ^prev_id]])
				|> Repo.update_all([])
		end
	end

	defp update_next_qentry(qentry_id, next_id) do
		if not is_nil(qentry_id) do
			from(q in "qentries", where: q.id == ^qentry_id, update: [set: [next_qentry_id: ^next_id]])
				|> Repo.update_all([])
		end
  end

  defp find_first_qentry(member_id, session_id, played \\ false) do
		query = from qentry in "qentries",
			where: (qentry.member_id == ^member_id)
				and (qentry.session_id == ^session_id)
        and is_nil(qentry.prev_qentry_id)
        and (qentry.played == ^played),
			select: qentry.id

		List.first(Repo.all(query))
	end

  defp find_last_qentry(member_id, session_id, played \\ false) do
		query = from qentry in "qentries",
			where: (qentry.member_id == ^member_id)
				and (qentry.session_id == ^session_id)
        and is_nil(qentry.next_qentry_id)
        and (qentry.played == ^played),
			select: qentry.id

    List.first(Repo.all(query))
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
