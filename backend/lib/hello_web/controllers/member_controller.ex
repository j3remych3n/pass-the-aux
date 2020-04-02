defmodule HelloWeb.MemberController do
  use HelloWeb, :controller

  def add(conn, _params) do
    text(conn, "add ok")
  end

  def get_songs(conn, _params) do
    text(conn, "get songs ok")
  end

end