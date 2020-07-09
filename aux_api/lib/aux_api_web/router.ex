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

    scope "/session" do
      post "/create", SessionController, :create_sess
      delete "/end", SessionController, :end_sess
    end

    scope "/member" do
      post "/auth", MemberController, :auth_member
      post "/create", MemberController, :auth_member
      delete "/delete", MemberController, :delete_member
    end

    scope "/test" do
      get "/find_qentries", TestController, :find_qentry_test
      get "/init_test_db", TestController, :init_test_db
      post "/change_pos", TestController, :change_pos
      get "/test_private_func", TestController, :test_private_func
			post "/create_member", TestController, :create_member
			post "/delete_song", TestController, :delete_song
			get "/get_songs", TestController, :get_songs
			post "/create_sess", TestController, :create_sess
			post "/end_sess", TestController, :end_sess
			post "/leave_sess", TestController, :leave_sess
      post "/add_song", TestController, :add_song
      post "/next", TestController, :next
      post "/auth_member", TestController, :auth_member
      delete "/delete_member", TestController, :delete_member
      get "/find_neighbor_qentries", TestController, :find_neighbor_qentries
    end

  end
end
