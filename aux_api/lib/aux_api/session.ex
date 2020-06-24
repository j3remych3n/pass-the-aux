defmodule AuxApi.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :is_host, :boolean, default: false
    field :member_id, :integer
    has_many :qentries, AuxApi.Qentry
    has_many :members, AuxApi.Member

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [])
    |> validate_required([])
  end
end
