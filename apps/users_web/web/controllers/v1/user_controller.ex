defmodule UsersWeb.V1.UserController do
  use UsersWeb.Web, :controller
  # import Users

  alias UsersWeb.V1.User

  def index(conn, _params) do
    users = Users.get
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"name" => name, "user_name" => user_name}) do
    user = Users.create(user_name, name)

    render(conn, "show.json", user: user)
  end

  # TODO
  def show(conn, %{"id" => id}) do
    render(conn, "show.json", user: [])
  end

  # TODO
  def update(conn, %{"id" => id, "user" => user_params}) do
    render(conn, "show.json", user: [])
  end

  # TODO
  def delete(conn, %{"id" => id}) do
    send_resp(conn, :no_content, "")
  end
end
