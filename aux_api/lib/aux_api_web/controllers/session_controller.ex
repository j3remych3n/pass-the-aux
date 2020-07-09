import Ecto.Query
import Ecto.Changeset
alias AuxApi.Repo

defmodule AuxApiWeb.SessionController do
	use AuxApiWeb, :controller
	
	def create_sess(conn, %{"host_id" => host_id}) do
		host_id = String.to_integer(host_id)

		session = %AuxApi.Session{host_id: host_id}
		{:ok, new_session} = AuxApi.Repo.insert(session)

		# {:reply, {:ok, %{host_id: host_member_id, session_id: new_session.id}}}		
		text(conn, "fine")
	end

  def end_sess(conn, %{"session_id" => session_id}) do
		session_id = String.to_integer(session_id)
		from(q in "qentries", where: q.session_id == ^session_id) |> Repo.delete_all
		from(s in "sessions", where: s.id == ^session_id) |> Repo.delete_all

		text(conn, "fine")
  end
end
