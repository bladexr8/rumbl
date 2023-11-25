defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts Context
  """

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def get_user(id) do
    Repo.get(User, id)
  end

  # User Not Found
  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def list_users do
    Repo.all(User)
  end

  # generate a changeset for User
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # create a new user
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # generate a user registration changeset
  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  # register user in database
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

end
