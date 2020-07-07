import Ecto.Query

defmodule AuxApiWeb.SessionController do
  use AuxApiWeb, :controller

  def create_session(conn, _params) do
    #   sess = %AuxApi.Session{}
    #   {:ok, curr_sess} = AuxApi.Repo.insert(sess)
    text(conn, "create session ok")
  end

  def delete_session(conn, _params) do
      text(conn, "delete session ok")
  end

end
