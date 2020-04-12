defmodule Hello.Repo.Migrations.SessionReferences do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      add :member_id, references(:members)
    end
  end
end
