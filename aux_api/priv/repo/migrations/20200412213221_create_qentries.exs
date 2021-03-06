defmodule AuxApi.Repo.Migrations.CreateQentries do
  use Ecto.Migration

  def change do
    create table(:qentries) do
      add :song_id, :string
      add :played, :boolean, default: false, null: false

      timestamps()
    end
  end
end
