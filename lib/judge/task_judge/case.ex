defmodule Judge.TaskJudge.Case do
  @derive Jason.Encoder
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :input, :string
    field :output, :string
  end

  @doc false
  def changeset(task_case, attrs) do
    task_case
    |> cast(attrs, [:input, :output])
    |> validate_required([:input, :output])
  end
end
