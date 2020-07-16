defmodule AuxApi.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :party, :boolean, default: false, null: false
      add :dictatorship, :boolean, default: false, null: false
      timestamps()
    end
  end
end
