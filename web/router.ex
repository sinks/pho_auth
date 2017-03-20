defmodule PhoAuth.Router do
  use PhoAuth.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoAuth do
    pipe_through :api
    # resources "/users", UserController, except: [:new, :edit, :index]
    post "/register", UserController, :create
    post "/login", UserController, :login
    post "/authorise", UserController, :authorise
  end
end
