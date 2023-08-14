defmodule Judge.TaskJudge.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    field :tl_millis, :integer
    belongs_to(:author, Judge.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :tl_millis, :author_id])
    |> validate_required([:title, :description, :tl_millis, :author_id])
    |> validate_number(:tl_millis, greater_than: 0, less_than: 5000)
  end
end
