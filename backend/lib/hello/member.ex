defmodule Hello.Member do
  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    has_many :qentries, Hello.Qentry

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end
end