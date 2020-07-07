defmodule AuxApi.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :spotify_uid, :string

      timestamps()
    end

  end
end
