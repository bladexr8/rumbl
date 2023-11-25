defmodule RumblWeb.UserController do
  use RumblWeb, :controller

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  # authenticated routes
  plug :authenticate when action in [:index, :show]

  # create new user
  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  # show all users
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  # show a single user
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  # create a new user
  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->

        conn
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # authenticate a user
  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

end
