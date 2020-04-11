defmodule Hello.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :member_id, :id

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [])
    |> validate_required([])
  end
end
