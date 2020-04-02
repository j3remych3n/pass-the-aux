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

     scope "/queue", HelloWeb do
       post "/add", QueueController
       post "/markPlayed", QueueController
       post "/changePos", QueueController
       delete "/remove", QueueController
       get "/next", QueueController
     end

     scope "/member", HelloWeb do
       post "/add", MemberController
       get "/getSongs", MemberController
     end

   end
end
