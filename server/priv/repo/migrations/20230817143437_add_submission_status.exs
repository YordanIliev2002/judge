defmodule Judge.Repo.Migrations.AddSubmissionStatus do
  use Ecto.Migration

  def change do
    alter table(:submissions) do
      add(:status, :string, default: "QUEUED")
    end
  end
end
