defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias UsersWeb.Repo
    end
  end

  def controller do
    quote do
      alias UsersWeb
      import UsersWeb.Router.Helpers

      @endpoint UsersWeb.Endpoint
    end
  end

  def view do
    quote do
      import UsersWeb.Router.Helpers
    end
  end

  def channel do
    quote do
      alias UsersWeb.Repo

      @endpoint UsersWeb.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
