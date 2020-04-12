defmodule AuxApi.Repo.Migrations.CreateQentries do
  use Ecto.Migration

  def change do
    create table(:qentries) do
      add :is_host, :boolean, default: false, null: false
      add :song_id, :string
      add :has_played, :boolean, default: false, null: false

      timestamps()
    end

  end
end
