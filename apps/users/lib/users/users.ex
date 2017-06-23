defmodule Users.Users do
  use GenServer

  defstruct [:id, :name, :user_name]

  defmodule State do
    defstruct [last_id: 0, users: %{}]
  end


  # Client API

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def create(user_name, name) do
    GenServer.call(__MODULE__, {:create, [user_name: user_name, name: name]})
  end

  def update(id, user_name, name) do
    GenServer.call(__MODULE__, {:update, [id: id, user_name: user_name, name: name]})
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def delete(id) do
    GenServer.call(__MODULE__, {:delete, id})
  end


   # Server Callbacks
   
  def init(_) do
    {:ok, %State{}}
  end

  def handle_call({:create, args}, _from, %State{users: users}) do

    %Users.User{}
    |> Users.User.changeset(%{name: args[:name], user_name: args[:user_name]})
    |> Users.Repo.insert
    |> (fn({:ok, user}) -> {:reply, Map.from_struct(user), %State{}}
          ({:error, changeset}) -> {:reply, changeset, %State{}} 
       end).()
  end

  def handle_call({:update, args}, _from, %State{users: users} = state) do
    user_id = args[:id]
    case users[user_id] do
      nil -> {:reply, :error, state}
      user ->
        update_user = %Users.Users{user | user_name: args[:user_name],
                                          name: args[:name]}
        new_state = %State{state | users: Map.put(users, user_id, update_user)}
        {:reply, :ok, new_state}
    end
  end

  def handle_call(:get, _from, %State{users: users} = state) do
    # list_user = users
    # |> Map.values
    # |> Enum.map(&(Map.from_struct/1))
    # |> Enum.map(&(Map.to_list/1))
    # {:reply, list_user, state}
    users = 
    Users.User 
    |> Users.Repo.all
    # |> Enum.map(fn(user) -> 
    #   # [name: user.name]
    #   [id: user.id, name: user.name, user_name: user.user_name]
    # end)

    {:reply, users, %State{}}
  end

  def handle_call({:get, id}, _from, %State{users: users} = state) do
    case Map.get(users, id) do
      nil -> {:reply, :error, state}
      user -> {:reply, user |> Map.from_struct |> Enum.into([]), state}
    end
  end

  def handle_call({:delete, id}, _from, %State{users: users} = state) do
    case Map.delete(users, id) do
      ^users -> {:reply, :error, state}
      new_users -> {:reply, :ok, %State{state | users: new_users}}
    end
  end

end
