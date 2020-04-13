defmodule AuxApiWeb.PageController do
  use AuxApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
