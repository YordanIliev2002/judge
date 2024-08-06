defmodule Judge.Repo.Migrations.CreateSubmissionsTable do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :code, :string, null: false
      add :task_id, references(:tasks, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:submissions, [:task_id, :user_id])
  end
end
