defmodule Judge.TaskJudge do
  @moduledoc """
  The TaskJudge context.
  """

  import Ecto.Query, warn: false
  require Logger

  alias Judge.Repo
  alias Judge.Rabbit
  alias Judge.TaskJudge.Task
  alias Judge.TaskJudge.Submission

  def list_tasks do
    Repo.all(Task)
  end

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(current_user, attrs \\ %{}) do
    %Task{author_id: current_user.id}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  def create_submission!(attrs \\ %{}) do
    {:ok, submission} = %Submission{}
    |> Submission.changeset(attrs)
    |> Repo.insert()
    task = Repo.get(Task, submission.task_id)
    Rabbit.send_for_evaluation(submission, task)
    submission
  end

  def get_submission_with_task!(submission_id) do
    Repo.get!(Submission, submission_id)
    |> Repo.preload([:task, :user])
  end

  def evaluate_submission(%{case_results: results, submission_id: id}) do
    score = get_score(results)
    res = Repo.get(Submission, id)
    |> Submission.changeset(%{status: "EVALUATED", case_results: results, score: score})
    |> Repo.update()
    res
  end

  defp get_score(results) when is_list(results) do
    ok_count = results |> Enum.count(&(&1 == "OK"))
    total_count = results |> Enum.count()
    div(100 * ok_count, total_count)
  end
end
