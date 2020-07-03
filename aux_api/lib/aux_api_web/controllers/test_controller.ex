import Ecto.Query
import Ecto.Changeset
alias AuxApi.Repo

defmodule AuxApiWeb.TestController do
	use AuxApiWeb, :controller

	# clear all tables
	def init_test_db(conn, _params) do
		Repo.delete_all("qentries")
		Repo.delete_all("sessions")
		Repo.delete_all("members")

		test_member = create_member(conn, _params)

		sess = %AuxApi.Session{is_host: true, member_id: test_member.id}
		{:ok, test_sess} = AuxApi.Repo.insert(sess)

		text(conn, "also fine")
	end

	def change_pos(conn, _params) do
		# tester params
		member_id = 3
		session_id = 3
		id = 82
		new_prev_id = 76

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
		text(conn, "ok")
	end

	def create_member(conn, _params) do
		text(conn, to_string(_create_member()))
	end

	defp _create_member() do
		member = %AuxApi.Member{}
		{:ok, test_member} = AuxApi.Repo.insert(member)
		test_member.id
	end

	def delete_song(conn, _params) do
		# song could be: beginning, middle, end
		qentry_id = 85

		prev_qentry_id = find_prev_qentry(qentry_id)
		next_qentry_id = find_next_qentry(qentry_id)

		update_prev_qentry(next_qentry_id, prev_qentry_id)
		update_next_qentry(prev_qentry_id, next_qentry_id)

		from(q in "qentries", where: q.id == ^qentry_id) |> Repo.delete_all
		text(conn, "fine")
	end

	def get_songs(conn, _params) do
		member_id = 3
		session_id = 3
 
		{qentry_id, song_id} = find_first_qentry(member_id, session_id)
		tracker = get_songs_recursive(qentry_id, [[qentry_id, song_id]])
		IO.inspect tracker
		text(conn, "fine")
	end

	def join_session(conn, _params) do
		session_id = 3
		member_id = 4

		session = %AuxApi.Session{id: session_id, member_id: member_id}
		{:ok, joined_session} = AuxApi.Repo.insert(session)

		update_num_members(session_id)
		text(conn, "fine")
	end

	def leave_session(conn, _params) do
		member_id = 4
		session_id = 3

		from(q in "qentries", where: q.member_id == ^member_id and q.session_id == ^session_id) |> Repo.delete_all
		from(s in "sessions", where: s.member_id == ^member_id and s.id == ^session_id) |> Repo.delete_all

		update_num_members(session_id)
		text(conn, "fine")
	end

	def create_sess(conn, _params) do
		host_member_id = 5

		if is_nil(host_member_id) do
			host_member_id = _create_member()
		end

		session = %AuxApi.Session{member_id: host_member_id, is_host: true}
		{:ok, new_session} = AuxApi.Repo.insert(session)

		# {:reply, {:ok, %{member_id: host_member_id, session_id: new_session.id}}}
		update_num_members(new_session.id)
		
		text(conn, "fine")
	end

	defp update_num_members(session_id) do
		query = from session in "sessions",
				where: (session.id == ^session_id),
				select: count("*")

		num_members = Repo.one(query)
		num_members
		# broadcast!(socket, "num_members", %{session_id: session_id, num_members: num_members})
	end

	defp get_songs_recursive(qentry_id, tracker) do
		{next_id, next_song_id} = find_song(find_next_qentry(qentry_id))
		if is_nil(next_id) do
			tracker
		else
			get_songs_recursive(next_id, tracker ++ [[next_id, next_song_id]])
		end
	end

	def add_song(conn, _params) do
		{prev_qentry_id, _} = find_last_qentry(3, 3)

		qentry = %AuxApi.Qentry{
			song_id: "2G7V7zsVDxg1yRsu7Ew9RJ",
			session_id: 3,
			member_id: 3,
			next_qentry_id: nil,
			prev_qentry_id: prev_qentry_id,
		}
		{:ok, test_qentry} = Repo.insert(qentry)

		update_next_qentry(prev_qentry_id, test_qentry.id)
		text(conn, "fine")
	end

	def test_private_func(conn, _params) do
		# {first, _} = find_first_qentry(3, 3)
		# {last, _} = find_last_qentry(3, 3)
		# forwards = print_qentry_order(first, Integer.to_string(first) <> " ")
		# backwards = print_qentry_order_backwards(last, Integer.to_string(last) <> " ")
		# text(conn, forwards <> "\n" <> backwards)
		text(conn, update_num_members(3))
	end

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

	defp find_song(qentry_id) do
		if not is_nil(qentry_id) do
			query = from qentry in "qentries",
				where: (qentry.id == ^qentry_id),
				select: {qentry.id, qentry.song_id}

			List.first(Repo.all(query))
		else
			{nil, nil}
		end
	end

	defp find_prev_qentry(qentry_id) do
		if not is_nil(qentry_id) do
			query = from qentry in "qentries",
				where: (qentry.id == ^qentry_id),
				select: qentry.prev_qentry_id

			List.first(Repo.all(query))
		else
			nil
		end
	end

	defp find_next_qentry(qentry_id) do
		if not is_nil(qentry_id) do
			query = from qentry in "qentries",
				where: (qentry.id == ^qentry_id),
				select: qentry.next_qentry_id

			List.first(Repo.all(query))
		else
			nil
		end
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

	defp find_first_qentry(member_id, session_id) do
		query = from qentry in "qentries",
			where: (qentry.member_id == ^member_id)
				and (qentry.session_id == ^session_id)
				and is_nil(qentry.prev_qentry_id)
				and (qentry.played == false),
			select: {qentry.id, qentry.song_id}

		res = List.first(Repo.all(query))

		if is_nil(res) do
			{nil, nil}
		else
			res
		end
	end

	defp find_last_qentry(member_id, session_id) do
		query = from qentry in "qentries",
			where: (qentry.member_id == ^member_id)
				and (qentry.session_id == ^session_id)
				and is_nil(qentry.next_qentry_id),
			select: {qentry.id, qentry.song_id}

		res = List.first(Repo.all(query))

		if is_nil(res) do
			{nil, nil}
		else
			res
		end
	end

end
