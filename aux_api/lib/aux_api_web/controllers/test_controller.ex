import Ecto.Query
import Ecto.Changeset
import AuxApi.AuxLibrary
alias AuxApi.Repo

defmodule AuxApiWeb.TestController do
	use AuxApiWeb, :controller

	# def init_test_db(conn, _params) do
	# 	Repo.delete_all("qentries")
	# 	Repo.delete_all("sessions")
	# 	Repo.delete_all("members")

	# 	test_member_id = _create_member()

	# 	sess = %AuxApi.Session{host_id: test_member_id}
	# 	{:ok, test_sess} = Repo.insert(sess)

	# 	json(conn, %{member_id: test_member_id, session_id: test_sess.id})
	# end

	# def change_pos(conn, _params) do
	# 	# tester params
	# 	member_id = 1
	# 	session_id = 1
	# 	id = 4
	# 	new_prev_id = 2

	# 	# link this qentry's previous and next (== remove this qentry)
	# 	# curr.prev.next = curr.next
	# 	# curr.next.prev = curr.prev
	# 	curr_prev_id = find_prev_qentry(id)
	# 	curr_next_id = find_next_qentry(id)

	# 	unless new_prev_id == curr_prev_id do
	# 		update_prev_qentry(curr_next_id, curr_prev_id)
	# 		update_next_qentry(curr_prev_id, curr_next_id)

	# 		# curr.next = new_prev.next
	# 		if is_nil(new_prev_id) do
	# 			# song needs to go to front of the queue
	# 			{new_next_id, _} = find_first_qentry(member_id, session_id)
	# 			update_prev_qentry(new_next_id, id)
	# 			update_next_qentry(id, new_next_id)
	# 		else
	# 			# song is now in the middle somewhere, or at the end
	# 			new_next_id = find_next_qentry(new_prev_id)
	# 			update_prev_qentry(new_next_id, id)
	# 			update_next_qentry(id, new_next_id)
	# 		end

	# 		# curr.prev = new_prev
	# 		# new_prev.next = curr
	# 		update_prev_qentry(id, new_prev_id)
	# 		update_next_qentry(new_prev_id, id)
	# 	end

	# 	text(conn, "ok")
	# end

	# def create_member(conn, _params) do
	# 	text(conn, to_string(_create_member()))
	# end

	# defp _create_member() do
	# 	member = %AuxApi.Member{}
	# 	{:ok, test_member} = Repo.insert(member)
	# 	test_member.id
	# end

	# def delete_song(conn, _params) do
	# 	# song could be: beginning, middle, end
	# 	qentry_id = 4

	# 	prev_qentry_id = find_prev_qentry(qentry_id)
	# 	next_qentry_id = find_next_qentry(qentry_id)

	# 	update_prev_qentry(next_qentry_id, prev_qentry_id)
	# 	update_next_qentry(prev_qentry_id, next_qentry_id)

	# 	from(q in "qentries", where: q.id == ^qentry_id) |> Repo.delete_all
	# 	text(conn, "fine")
	# end

	# def get_songs(conn, _params) do
	# 	member_id = 1
	# 	session_id = 1

	# 	{qentry_id, song_id} = find_first_qentry(member_id, session_id)
	# 	tracker = get_songs_recursive(qentry_id, [[qentry_id, song_id]])
	# 	IO.inspect tracker
	# 	text(conn, "fine")
	# end

	# def leave_sess(conn, _params) do
	# 	member_id = 2
	# 	session_id = 1

	# 	from(q in "qentries", where: q.member_id == ^member_id and q.session_id == ^session_id) |> Repo.delete_all
	# 	text(conn, "fine")
	# end

	# @optional_params %{"host_id" => nil}
	# def create_sess(conn, _params) do
	# 	_params = Map.merge(@optional_params, _params)

	# 	%{"host_id" => host_id} = _params
	# 	host_id = if is_nil(host_id) do _create_member() else String.to_integer(host_id) end

	# 	session = %AuxApi.Session{host_id: host_id}
	# 	{:ok, new_session} = Repo.insert(session)

	# 	# {:reply, {:ok, %{host_id: host_member_id, session_id: new_session.id}}}
	# 	text(conn, "fine")
	# end

	# def end_sess(conn, %{"session_id" => session_id}) do
	# 	session_id = String.to_integer(session_id)
	# 	from(q in "qentries", where: q.session_id == ^session_id) |> Repo.delete_all
	# 	from(s in "sessions", where: s.id == ^session_id) |> Repo.delete_all

	# 	text(conn, "fine")
	# end

	# defp get_songs_recursive(qentry_id, tracker) do
	# 	{next_id, next_song_id} = find_song(find_next_qentry(qentry_id))
	# 	if is_nil(next_id) do
	# 		tracker
	# 	else
	# 		get_songs_recursive(next_id, tracker ++ [[next_id, next_song_id]])
	# 	end
	# end

	# def add_song(conn, %{"member_id" => mid, "session_id" => sid}) do
	# 	member_id = String.to_integer(mid)
	# 	session_id = String.to_integer(sid)

	# 	{prev_qentry_id, _} = find_last_qentry(member_id, session_id)

	# 	qentry = %AuxApi.Qentry{
	# 		song_id: "2G7V7zsVDxg1yRsu7Ew9RJ",
	# 		member_id: member_id,
	# 		session_id: session_id,
	# 		next_qentry_id: nil,
	# 		prev_qentry_id: prev_qentry_id,
	# 	}
	# 	{:ok, test_qentry} = Repo.insert(qentry)

	# 	update_next_qentry(prev_qentry_id, test_qentry.id)
	# 	text(conn, "added " <> to_string(test_qentry.id))
	# end

	# def auth_member(conn, %{"spotify_uid" => spotify_uid}) do
	# 	member_id = find_member(spotify_uid)
	# 	if is_nil(member_id) do # New member
	# 		{:ok, member} = %AuxApi.Member{spotify_uid: spotify_uid} |> Repo.insert
	# 		json(conn, %{auth_token: member.id})
	# 	else # Existing member
	# 		json(conn, %{auth_token: member_id})
	# 	end
	# end

	# def delete_member(conn, %{"spotify_uid" => spotify_uid, "member_id" => mid}) do
	# 	member_id = String.to_integer(mid)

	# 	if member_id == find_member(spotify_uid) do
	# 		from(member in "members", where: member.id == ^member_id) |> Repo.delete_all
	# 		conn |> put_status(200) |> json(%{})
	# 	else
	# 		conn |> put_status(403) |> json(%{error: "invalid authentication / member does not exist"})
	# 	end

	# end

	# def next(conn, %{"member_id" => mid, "session_id" => sid}) do
	# 	member = String.to_integer(mid)
	# 	session = String.to_integer(sid)

	# 	{qentry, _} = find_first_qentry(member, session)
	# 	if is_nil(qentry) do
	# 		json(conn, %{debug_queue: "no songs in queue"})
	# 	else
	# 		song_id = mark_played(member, session, qentry)
	# 		json(conn, %{qentry_id: qentry, song_id: song_id})
	# 	end
	# end

	# defp mark_played(member_id, session_id, qentry_id) do
	# 	get_neighbors = from q in "qentries",
	# 		where: (q.id == ^qentry_id),
	# 		select: {q.prev_qentry_id, q.next_qentry_id}
	# 	if not is_nil(qentry_id) do
	# 		{prev, next} = List.first(Repo.all(get_neighbors))

	# 		if not is_nil(prev) do
	# 			from(q in "qentries", where: q.id == ^prev, update: [set: [next_qentry_id: ^next]])
  #       |> Repo.update_all([])
	# 		end

	# 		if not is_nil(next) do
	# 			from(q in "qentries", where: q.id == ^next, update: [set: [prev_qentry_id: ^prev]])
  #       |> Repo.update_all([])
	# 		end

	# 		{last_played, _} = find_last_qentry(member_id, session_id, true)
	# 		if not is_nil(last_played) do
	# 			from(q in "qentries", where: q.id == ^last_played, update: [set: [next_qentry_id: ^qentry_id,]])
	# 			|> Repo.update_all([])
	# 		end
	# 		from(q in "qentries", where: q.id == ^qentry_id,
	# 			update: [
	# 				set: [
	# 					played: true,
	# 					next_qentry_id: nil,
	# 					prev_qentry_id: ^last_played,
	# 				]])
	# 		|> Repo.update_all([])
	# 		# not_played = "empty"
	# 		# if not is_nil(next) do
	# 		# 	not_played = print_qentry_order(next, Integer.to_string(next) <> " ")
	# 		# 	played = print_qentry_order_backwards(qentry_id, Integer.to_string(qentry_id) <> " ")
	# 		# 	"played: " <> played <> "\nnot played: " <> not_played
	# 		# else
	# 		# 	played = print_qentry_order_backwards(qentry_id, Integer.to_string(qentry_id) <> " ")
	# 		# 	song_id, "played: " <> played <> "\nnot played: " <> not_played
	# 		# end

	# 		get_next_song = from qentry in "qentries",
	# 			where: (qentry.id == ^next),
	# 			select: qentry.song_id
	# 		song_id = List.first(Repo.all(get_next_song))
	# 	end
  # end

	# def test_private_func(conn, _params) do
	# 	{first, _} = find_first_qentry(1, 1)
	# 	{last, _} = find_last_qentry(1, 1)
	# 	forwards = print_qentry_order(first, Integer.to_string(first) <> " ")
	# 	backwards = print_qentry_order_backwards(last, Integer.to_string(last) <> " ")
	# 	text(conn, forwards <> "\n" <> backwards)
	# end

	defp print_qentry_order(curr_id, tracker) do
		next_id = find_next_qentry(curr_id)
		if is_nil(next_id) do
			tracker
		else
			print_qentry_order(next_id, tracker <> Integer.to_string(next_id) <> " ")
		end
	end

	defp print_qentry_order_backwards(curr_id, tracker) do
		prev_id = find_prev_qentry(curr_id)
		if is_nil(prev_id) do
			tracker
		else
			print_qentry_order_backwards(prev_id, tracker <> Integer.to_string(prev_id) <> " ")
		end
	end
end
