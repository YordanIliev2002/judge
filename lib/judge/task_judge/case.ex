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
    |> not_null(:input)
    |> not_null(:output)
  end

  defp not_null(changeset, field) when is_atom(field) do
    validate_change(changeset, field, fn field, value ->
      case value do
        nil -> [{field, "#{field} should not be null"}]
        _ -> []
      end
    end)
  end
end
