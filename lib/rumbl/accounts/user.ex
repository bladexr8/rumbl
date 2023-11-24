# Users Context
defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  #replaces defstruct [:id, :name, :username]

  # define database table and
  # struct at same time
  # primary key :id is
  # auto defined
  schema "users" do
    field :name, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

end
