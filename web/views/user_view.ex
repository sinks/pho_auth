defmodule PhoAuth.UserView do
  use PhoAuth.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, PhoAuth.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{username: user.username}
  end
end
