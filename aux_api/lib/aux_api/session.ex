defmodule AuxApi.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :party, :boolean, default: true
    field :dictatorship, :boolean, default: true
    field :host_id, :integer
    has_many :qentries, AuxApi.Qentry
    has_one :members, AuxApi.Member

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [])
    |> validate_required([])
  end
end
