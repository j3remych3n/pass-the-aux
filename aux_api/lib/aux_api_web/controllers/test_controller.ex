import Ecto.Query
import Ecto.Changeset
alias AuxApi.Repo

defmodule AuxApiWeb.TestController do
	use AuxApiWeb, :controller

	def init_test_db(conn, _params) do
		Repo.delete_all("qentries")
		Repo.delete_all("sessions")
		Repo.delete_all("members")

		test_member = _create_member()

		sess = %AuxApi.Session{is_host: true, member_id: test_member}
		{:ok, test_sess} = AuxApi.Repo.insert(sess)

		json(conn, %{member_id: test_member, session_id: test_sess.id})
	end

	def create_member(conn, _params) do
		text(conn, to_string(_create_member()))
	end

	defp _create_member() do
		member = %AuxApi.Member{}
		{:ok, test_member} = AuxApi.Repo.insert(member)
		test_member.id
	end

	def add_song(conn, %{"member_id" => mid, "session_id" => sid}) do
		member_id = String.to_integer(mid)
		session_id = String.to_integer(sid)

		prev_qentry_id = find_last_qentry(member_id, session_id)

		qentry = %AuxApi.Qentry{
			song_id: "2G7V7zsVDxg1yRsu7Ew9RJ",
			member_id: member_id,
			session_id: session_id,
			next_qentry_id: nil,
			prev_qentry_id: prev_qentry_id,
		}
		{:ok, test_qentry} = Repo.insert(qentry)

		update_next_qentry(prev_qentry_id, test_qentry.id)
		text(conn, "added " <> to_string(test_qentry.id))
	end

	def next(conn, %{"member_id" => mid, "session_id" => sid}) do
		member = String.to_integer(mid)
		session = String.to_integer(sid)

		qentry = find_first_qentry(member, session)
		if is_nil(qentry) do
			json(conn, %{debug_queue: "no songs in queue"})
		else
			song_id = mark_played(member, session, qentry)
			json(conn, %{qentry_id: qentry, song_id: song_id})
		end
	end

	def auth_member(conn, %{"spotify_uid" => spotify_uid}) do
		member_id = find_member(spotify_uid)
		if is_nil(member_id) do
			{:ok, member} = %AuxApi.Member{spotify_uid: spotify_uid} |> AuxApi.Repo.insert
			json(conn, ${auth_token: member.id})
		else
			json(conn, %{auth_token: member_id})
		end
	end

	def delete_member(conn, ${"spotify_uid" => spotify_uid, "member_id" => mid}) do
		member_id = String.to_integer(mid)

		if member_id == find_member(spotify_uid) do
			from(member in "members", where: member.id == ^member_id) |> AuxApi.Repo.delete_all
			conn |> put_status(200)
		else
			conn |> put_status(403)
		end
	end

	defp find_member(spotify_uid) do
		query = from member in "members",
			where: (member.spotify_uid == ^spotify_uid),
			select: member.id
		member_result = Repo.all(query)

		case length(member_result) do
			1 -> List.first(member_result)
			_ -> nil
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

			last_played = find_last_qentry(member_id, session_id, true)
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

	def find_qentry_test(conn, _params) do
		first = find_first_qentry(4, 4)
		last = find_last_qentry(4, 4)
		forwards = print_qentry_order(first, Integer.to_string(first) <> " ")
		backwards = print_qentry_order_backwards(last, Integer.to_string(last) <> " ")
		text(conn, forwards <> "\n" <> backwards)
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

end
