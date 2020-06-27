defmodule AuxApi.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :is_host, :boolean, default: false, null: false
      timestamps()
    end

  end
end
