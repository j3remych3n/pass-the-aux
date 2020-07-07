import Ecto.Query
import Ecto.Changeset
alias AuxApi.Repo

defmodule AuxApiWeb.SessionController do
  use AuxApiWeb, :controller

  @optional_params %{"host_id" => nil}
	def create_sess(conn, _params) do
		_params = Map.merge(@optional_params, _params)

		%{"host_id" => host_id} = _params
		host_id = if is_nil(host_id) do _create_member() else String.to_integer(host_id) end

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
  
  defp _create_member() do
		member = %AuxApi.Member{}
		{:ok, new_member} = AuxApi.Repo.insert(member)
		new_member.id
	end

end
