defmodule PhoAuth.UserController do
  use PhoAuth.Web, :controller

  require Logger

  alias PhoAuth.User
  alias PhoAuth.Jwt

  def create(conn, %{"username" => username, "password" => password}) do
    changeset = User.changeset(%User{}, %{username: username, password: password})

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("user.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoAuth.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def login(conn, %{"username" => username, "password" => password})
  when is_binary(username) and is_binary(password)
  do
      user = Repo.get_by(User, username: username)
      login_user(conn, user, User.hash_password(password))
  end

  def login_user(conn, %User{username: username, password: password}, password) do
    Logger.info "auth user #{username}"
    {:ok , jwt} = Jwt.encode("HS256", %{username: username}, "secret")

    conn
    |> put_status(:ok)
    |> json(%{token: jwt})
  end

  def login_user(conn, nil, _password) do
    Logger.info "auth failed"
    conn
    |> put_status(:bad_request)
    |> json(%{})
  end

  def authorise(conn, _params) do
    header = get_req_header(conn, "authorization")
    authorise_token(conn, header)
  end

  def authorise_token(conn, ["token " <> token | _]) do
    case Jwt.valid(token, "secret") do
      {:ok, %{header: header, body: body}} ->
        conn
        |> put_status(:ok)
        |> json(%{header: header, body: body})
      {:error} ->
        conn
        |> put_status(:bad_request)
        |> json(%{})
    end
  end

  def authorise_token(conn, _other) do
    conn
    |> put_status(:bad_request)
    |> json(%{})
  end
end
