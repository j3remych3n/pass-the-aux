defmodule Hello.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end

    create index(:sessions, [:member_id])
  end
end
