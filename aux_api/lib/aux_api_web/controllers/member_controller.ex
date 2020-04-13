defmodule AuxApiWeb.MemberController do
  use AuxApiWeb, :controller
  
  def get_songs(conn, _params) do
    text(conn, "get songs ok")
  end
  
end