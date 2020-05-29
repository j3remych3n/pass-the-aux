defmodule AuxApiWeb.SpotifyApiController do
    use AuxApiWeb, :controller
  
    def authenticate(conn, params) do
      case Spotify.Authentication.authenticate(conn, params) do
        {:ok, conn } ->
          # do stuff
        #   redirect conn, to: "/whereever-you-want-to-go"
            text(conn, "authenticate ok")
        { :error, reason, conn }-> 
            # redirect conn, to: "/error"
            text(conn, "error")
      end
    end

    def authorize(conn, params) do
      redirect conn, external: Spotify.Authorization.url
    end
  end