defmodule Users.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :user_name, :string

    timestamps()
  end


  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:name, :user_name])
    |> Ecto.Changeset.validate_required([:name, :user_name])
  end
end