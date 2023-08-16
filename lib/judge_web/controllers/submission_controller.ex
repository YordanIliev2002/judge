defmodule JudgeWeb.SubmissionController do
  use JudgeWeb, :controller
  require Logger
  alias Judge.TaskJudge

  def create(conn, %{"task_id" => task_id, "code" => code}) do
    Logger.info("Submitting, task: #{task_id}, code: #{code}")
    TaskJudge.create_submission(%{
      task_id: task_id,
      user_id: conn.assigns.current_user.id,
      code: code
    })
    redirect(conn, to: ~p"/tasks/#{task_id}")
  end
end
