defmodule HelloWeb.MemberController do
  use HelloWeb, :controller

  def get_songs(conn, _params) do
    text(conn, "get songs ok")
  end

end