defmodule Judge.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :tl_millis, :integer, null: false
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:author_id])
  end
end
