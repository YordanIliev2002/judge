defmodule Judge.TaskJudge.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :code, :string
    field :status, :string
    belongs_to(:user, Judge.Accounts.User)
    belongs_to(:task, Judge.TaskJudge.Task)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:user_id, :code, :task_id])
    |> validate_required([:user_id, :code, :task_id])
    |> validate_inclusion(:status, ["QUEUED", "EVALUATED"])
    |> validate_length(:code, min: 0, max: 5000)
  end
end
