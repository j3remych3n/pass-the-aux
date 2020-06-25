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

	def create_member(conn, _params) do
		text(conn, to_string(_create_member(conn, _params)))
	end

	defp _create_member(conn, _params) do
		member = %AuxApi.Member{}
		{:ok, test_member} = AuxApi.Repo.insert(member)
		test_member.id
	end

	def add_song(conn, _params) do

		prev_qentry_id = find_prev_qentry(4, 4)

		qentry = %AuxApi.Qentry{
			song_id: "2G7V7zsVDxg1yRsu7Ew9RJ",
			session_id: 4,
			member_id: 4,
			next_qentry_id: nil,
			prev_qentry_id: prev_qentry_id,
		}
		{:ok, test_qentry} = Repo.insert(qentry)
		update_next_qentry(prev_qentry_id, test_qentry.id)
		text(conn, "fine")
	end

	defp update_next_qentry(qentry_id, next_id) do
		from(q in "qentries", where: q.id == ^qentry_id, update: [set: [next_qentry_id: ^next_id]])
			|> Repo.update_all([])
	end

	defp find_prev_qentry(member_id, session_id) do
		query = from qentry in "qentries",
			where: (qentry.member_id == ^member_id)
				and (qentry.session_id == ^session_id)
				and is_nil(qentry.next_qentry_id),
			select: qentry.id

		first(Repo.all(query))
	end

end
