defmodule Judge.Repo.Migrations.AddEvaluationResultToSubmissions do
  use Ecto.Migration

  def change do
    alter table(:submissions) do
      add(:case_results, {:array, :string}, default: nil)
      add(:score, :integer, default: nil)
    end
  end
end
