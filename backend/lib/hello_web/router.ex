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
       post "/add", QueueController, :add
       post "/mark_played", QueueController, :mark_played
       post "/change_pos", QueueController, :change_pos
       delete "/remove", QueueController, :remove
       get "/next", QueueController, :next
     end

     scope "/member" do
       post "/add", MemberController, :add
       get "/get_songs", MemberController, :get_songs
     end

   end
end
