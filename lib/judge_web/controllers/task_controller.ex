defmodule JudgeWeb.TaskController do
  use JudgeWeb, :controller

  alias Judge.TaskJudge
  alias Judge.TaskJudge.Task

  def index(conn, _params) do
    tasks = TaskJudge.list_tasks()
    render(conn, :index, tasks: tasks)
  end

  def new(conn, _params) do
    changeset = TaskJudge.change_task(%Task{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    task_params = deserialize_cases(task_params)
    case TaskJudge.create_task(conn.assigns.current_user, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = TaskJudge.get_task!(id)
    render(conn, :show, task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = TaskJudge.get_task!(id)
    user_id = conn.assigns.current_user.id
    task = serialize_cases(task)
    case task.author_id do
      ^user_id ->
        render(conn, :edit, task: task, changeset: TaskJudge.change_task(task))
      _ ->
        conn
        |> put_flash(:error, "Forbidden!")
        |> redirect(to: ~p"/tasks/#{task}")
    end
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = TaskJudge.get_task!(id)
    task_params = deserialize_cases(task_params)

    case TaskJudge.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: ~p"/tasks/#{task}")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "You provided invalid info.")
        |> render(:edit, task: task, changeset: TaskJudge.change_task(serialize_cases(task)))
    end
  end

  def delete(conn, %{"id" => id}) do
    task = TaskJudge.get_task!(id)
    user_id = conn.assigns.current_user.id
    case task.author_id do
      ^user_id ->
        {:ok, _task} = TaskJudge.delete_task(task)
        conn
        |> put_flash(:info, "Task deleted successfully.")
        |> redirect(to: ~p"/tasks")
      # TODO - extract common error handling
      _ ->
        conn
        |> put_flash(:error, "Forbidden!")
        |> redirect(to: ~p"/tasks/#{task}")
    end

  end

  defp serialize_cases(%Task{} = task) do
    {:ok, cases} = Jason.encode(task.cases)
    Map.put(task, :cases, cases)
  end

  defp deserialize_cases(%{"cases" => raw_cases} = task_params) do
    {:ok, cases} = Jason.decode(raw_cases)
    Map.put(task_params, "cases", cases)
  end
end
