defmodule TaskTrackerWeb.UserController do
  use TaskTrackerWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias TaskTracker.Users
  alias TaskTracker.Users.User
  alias TaskTracker.Repo
  alias TaskTracker.Tasks

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    users = Users.list_users()
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    users = Users.list_users()
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.task_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    listUsers = Users.list_users()
    tasks = Tasks.list_tasks
    thouManage = Repo.all from u in User, where: ^id == u.manager_id;
    render(conn, "show.html", user: user, thouManage: thouManage, listUsers: listUsers, tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    users = Users.list_users()
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, users: users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)
    users = Users.list_users()
    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset, users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

end
