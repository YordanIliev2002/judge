defmodule Judge.Repo.Migrations.AddCases do
  use Ecto.Migration
  alias Judge.TaskJudge.Case

  def change do
    alter table(:tasks) do
      add(:cases, {:array, :map}, default: [])
    end
  end
end
