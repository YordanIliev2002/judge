defmodule Amqp.Dto.SubmissionAdded do
  @derive Jason.Encoder
  defstruct [:cases, :submission_id, :code, :tl_millis]
  alias Amqp.Dto.SubmissionAdded
  alias Judge.TaskJudge.Submission
  alias Judge.TaskJudge.Task

  def from(
    %Submission{code: code, id: submission_id},
    %Task{cases: cases, tl_millis: tl_millis}
  ) do
    %SubmissionAdded{
      cases: cases,
      submission_id: submission_id,
      code: code,
      tl_millis: tl_millis
    }
  end
end
