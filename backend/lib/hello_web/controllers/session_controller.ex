defmodule HelloWeb.SessionController do
    use HelloWeb, :controller
  
    def add_member(conn, _params) do
        text(conn, "add member ok")
    end

    def delete_member(conn, _params) do
        text(conn, "delete member ok")
    end
  
end