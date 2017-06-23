defmodule UsersWeb.V1.UserView do
  use UsersWeb.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UsersWeb.V1.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UsersWeb.V1.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name, user_name: user.user_name}
  end
end
