defmodule TaskTrackerWeb.TaskController do
  use TaskTrackerWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias TaskTracker.Tasks
  alias TaskTracker.Tasks.Task
  alias TaskTracker.Users
  alias TaskTracker.Users.User
  alias TaskTracker.TimeBlocks.TimeBlock

  alias TaskTracker.Repo

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    users = Users.list_users()
    render(conn, "index.html", tasks: tasks, users: users)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    users = Users.list_users()

    currentUserId = conn.assigns[:current_user].id
    myUnderlings = Repo.all from u in User,
            where: u.manager_id == ^currentUserId; 

    render(conn, "new.html", changeset: changeset, users: users, myUnderlings: myUnderlings)
  end

  def create(conn, %{"task" => task_params}) do
    currentUserId = conn.assigns[:current_user].id
    myUnderlings = Repo.all from u in User,
            where: u.manager_id == ^currentUserId;     
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, myUnderlings: myUnderlings)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    currentUserId = conn.assigns[:current_user].id
    myUnderlings = Repo.all from u in User,
            where: u.manager_id == ^currentUserId; 
            
    render(conn, "show.html", task: task, myUnderlings: myUnderlings)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    users = Users.list_users()

    currentUserId = conn.assigns[:current_user].id
    myUnderlings = Repo.all from u in User,
            where: u.manager_id == ^currentUserId; 

    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, users: users, myUnderlings: myUnderlings)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)
    users = Users.list_users()
    currentUserId = conn.assigns[:current_user].id
    myUnderlings = Repo.all from u in User,
            where: u.manager_id == ^currentUserId; 
    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset, users: users, myUnderlings: myUnderlings)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
