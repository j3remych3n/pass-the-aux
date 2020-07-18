import Ecto.Query
alias AuxApi.Repo
import AuxApi.DbActions

defmodule AuxApiWeb.SessionController do
  use AuxApiWeb, :controller

  def create_sess(conn, %{"spotify_uid" => spotify_uid, "member_id" => mid}) do
    member_id = String.to_integer(mid)
    # host_id = find_member(spotify_uid)
    host_id = member_id # TODO FIX THIS

    if is_nil(host_id) do #or member_id != host_id do
      conn
      |> put_status(403)
      |> json(%{
        host_id: host_id,
        session_id: nil,
        error: "invalid authentication | member does not exist"
      })
    end

    session = %AuxApi.Session{host_id: host_id}
    {:ok, new_session} = Repo.insert(session)
    json(conn, %{host_id: host_id, session_id: new_session.id})
  end

  def end_sess(conn, %{"spotify_uid" => spotify_uid, "session_id" => sessid, "member_id" => mid}) do
    member_id = String.to_integer(mid)
    session_id = String.to_integer(sessid)
    host_id = find_member(spotify_uid)
    find_session = from(s in "sessions", where: s.id == ^session_id)

    session = find_session |> Repo.all() |> List.first()

    if host_id != member_id or session.host_id != host_id do
      conn
      |> put_status(403)
      |> json(%{
        host_id: host_id,
        session_id: nil,
        error: "insufficient permissions | member does not exist"
      })
    else
      from(q in "qentries", where: q.session_id == ^session_id) |> Repo.delete_all()
      find_session |> Repo.delete_all()

      json(conn, %{})
    end
  end
end
