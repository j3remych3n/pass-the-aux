defmodule AuxApi.Repo.Migrations.QentryReferences do
  use Ecto.Migration

  def change do
    alter table(:qentries) do
      add :session_id, references(:sessions)
      add :member_id, references(:members)
      add :next_qentry_id, references(:qentries)
      add :prev_qentry_id, references(:qentries)
    end
  end
end
