defmodule AuxApi.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do

      timestamps()
    end

  end
end
