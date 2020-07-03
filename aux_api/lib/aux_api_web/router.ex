defmodule AuxApiWeb.Router do
  use AuxApiWeb, :router

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

  scope "/", AuxApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", AuxApiWeb do
    pipe_through :api

    # scope "/queue" do
    #   post "/add_song", QueueController, :add_song
    #   put "/mark_played", QueueController, :mark_played
    #   put "/change_pos", QueueController, :change_pos
    #   delete "/delete_song", QueueController, :delete_song
    #   get "/next", QueueController, :next
    # end

    # scope "/member" do
    #   get "/get_songs", MemberController, :get_songs
    # end

    scope "/session" do
      post "/create_sess", SessionController, :create_session
      delete "/delete_sess", SessionController, :delete_session
      post "/add_member", SessionController, :add_member
      delete "/delete_member", SessionController, :delete_member
      get "/authenticate", SpotifyApiController, :authenticate
      get "/authorize", SpotifyApiController, :authorize
    end

    scope "/test" do
      post "/add_song", TestController, :add_song
      get "/init_test_db", TestController, :init_test_db
      post "/change_pos", TestController, :change_pos
      get "/test_private_func", TestController, :test_private_func
			post "/create_member", TestController, :create_member
			post "/delete_song", TestController, :delete_song
			get "/get_songs", TestController, :get_songs
			post "/create_sess", TestController, :create_sess
			post "/end_sess", TestController, :end_sess
			post "/leave_sess", TestController, :leave_sess
    end

  end
end
