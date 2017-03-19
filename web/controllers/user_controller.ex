defmodule PhoAuth.UserController do
  use PhoAuth.Web, :controller

  alias PhoAuth.User

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoAuth.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def login(conn, %{"user" => user_params}) do
    # check user exists
    # encrypt password
    # Jwt.encode(%{username: user.username})
    # generate jwt of username
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoAuth.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
