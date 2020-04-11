defmodule Hello.Repo.Migrations.CreateQentries do
  use Ecto.Migration

  def change do
    create table(:qentries) do
      add :is_host, :boolean, default: false, null: false
      add :song_id, :string
      add :has_played, :boolean, default: false, null: false
      add :session_id, references(:sessions, on_delete: :nothing)
      add :member_id, references(:members, on_delete: :nothing)
      add :next_qentry_id, references(:qentries, on_delete: :nothing)
      add :prev_qentry_id, references(:qentries, on_delete: :nothing)

      timestamps()
    end

    create index(:qentries, [:session_id])
    create index(:qentries, [:member_id])
    create index(:qentries, [:next_qentry_id])
    create index(:qentries, [:prev_qentry_id])
  end
end
