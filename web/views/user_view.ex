defmodule PhoAuth.UserView do
  use PhoAuth.Web, :view

  def render("user.json", %{user: user}) do
    %{username: user.username}
  end
end
