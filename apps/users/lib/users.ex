defmodule Users do

  def create(user_name, name) do
    Users.Users.create(user_name, name)
  end

  def update(id, user_name, name) do
    Users.Users.update(id, user_name, name)
  end

  def get do
    Users.Users.get
  end

  def get(id) do
    Users.Users.get(id)
  end

  def delete(id) do
    Users.Users.delete(id)
  end
end
