defmodule JudgeWeb.SubmissionController do
  use JudgeWeb, :controller
  require Logger
  alias Judge.TaskJudge

  def create(conn, %{"task_id" => task_id, "code" => code}) do
    Logger.info("Submitting, task: #{task_id}, code: #{code}")
    submission = TaskJudge.create_submission!(%{
      task_id: task_id,
      user_id: conn.assigns.current_user.id,
      code: code
    })
    redirect(conn, to: ~p"/submissions/#{submission.id}")
  end

  def show(conn, %{"submission_id" => submission_id}) do
    submission = TaskJudge.get_submission_with_task!(submission_id)
    task = submission.task
    user_id = conn.assigns.current_user.id
    has_access = user_id in [task.author_id, submission.user_id]
    case has_access do
      true ->
        render(conn, :show, submission: submission)
      _ ->
        conn
        |> put_flash(:error, "Forbidden!")
        |> redirect(to: ~p"/tasks/#{task}")
    end
  end
end
