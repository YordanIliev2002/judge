defmodule Judge.TaskJudge.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :code, :string
    field :status, :string
    field :case_results, {:array, :string}
    field :score, :integer

    belongs_to(:user, Judge.Accounts.User)
    belongs_to(:task, Judge.TaskJudge.Task)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:user_id, :code, :task_id, :status, :case_results, :score])
    |> validate_required([:user_id, :code, :task_id])
    |> validate_inclusion(:status, ["QUEUED", "EVALUATED"])
    |> validate_length(:code, min: 0, max: 5000)
    |> validate_number(:score, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end
end
