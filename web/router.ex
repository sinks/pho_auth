defmodule PhoAuth.Router do
  use PhoAuth.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoAuth do
    pipe_through :api
  end
end
