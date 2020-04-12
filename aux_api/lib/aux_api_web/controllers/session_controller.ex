defmodule AuxApiWeb.SessionController do
  use AuxApiWeb, :controller

  def add_member(conn, _params) do
      text(conn, "add member ok")
  end

  def delete_member(conn, _params) do
      text(conn, "delete member ok")
  end

  def create_session(conn, _params) do
      sess = %AuxApi.Session{}
      {:ok, curr_sess} = AuxApi.Repo.insert(sess)
      text(conn, "create session ok")
  end

  def delete_session(conn, _params) do
      text(conn, "delete session ok")
  end

end