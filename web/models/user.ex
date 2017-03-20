defmodule PhoAuth.User do
  use PhoAuth.Web, :model

  schema "users" do
    field :username, :string
    field :password, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
    |> update_change(:password, &hash_password(&1))
    |> unique_constraint(:username)
  end

  def hash_password(password) do
    Base.encode16(:crypto.hash(:sha256, password))
  end
end
