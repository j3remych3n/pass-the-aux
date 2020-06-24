import Ecto.Query

defmodule AuxApiWeb.TestController do
	use AuxApiWeb, :controller

	# clear all tables
	def init_test_db(conn, _params) do
		AuxApi.Repo.delete_all("qentries")
		AuxApi.Repo.delete_all("sessions")
		AuxApi.Repo.delete_all("members")

		member = %AuxApi.Member{}
    {:ok, test_member} = AuxApi.Repo.insert(member)
		
		sess = %AuxApi.Session{is_host: true, member_id: test_member.id}
		{:ok, test_sess} = AuxApi.Repo.insert(sess)

		text(conn, "also fine")
	end

	def add_song(conn, _params) do
		qentry = %AuxApi.Qentry{
			song_id: "spotify:track:2G7V7zsVDxg1yRsu7Ew9RJ", 
			session_id: 2, 
			member_id: 2, 
			next_qentry_id: nil, 
			prev_qentry_id: nil,
		}

		{:ok, test_qentry} = AuxApi.Repo.insert(qentry)
		text(conn, "fine")
	end

	def find_prev_entry(conn, _params) do
		member_id = 2
		session_id = 2

		# query = from qentry in "qentries", 
		# 	# where: qentry.member_id == ^member_id and qentry.session_id == ^session_id and is_nil(qentry.next_qentry_id),
		# 	select: qentry.song_id

		query = from qentry in "qentries",
  		where: qentry.member_id == ^member_id and qentry.session_id == ^session_id and is_nil(qentry.next_qentry_id),
  		select: struct(qentry, [:id])

		IO.puts AuxApi.Repo.all(query)
		text(conn, "fine")
	end

end