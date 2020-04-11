defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

#   Other scopes may use custom stacks.
   scope "/api", HelloWeb do
     pipe_through :api

     scope "/queue" do
       post "/song", QueueController, :add_song
       put "/mark_played", QueueController, :mark_played
       put "/change_pos", QueueController, :change_pos
       delete "/song", QueueController, :delete_song
       get "/next", QueueController, :next
     end

     scope "/member" do
       get "/get_songs", MemberController, :get_songs
     end

     scope "/session" do
       post "/member", SessionController, :add_member
       delete "/member", SessionController, :delete_member
     end

   end
end
