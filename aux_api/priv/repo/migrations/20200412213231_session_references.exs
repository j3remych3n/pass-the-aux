defmodule AuxApi.Repo.Migrations.SessionReferences do
  use Ecto.Migration

  def change do

    alter table(:sessions) do
      add :host_id, references(:members)
    end
  end
end

