defmodule AuxApi.Qentry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "qentries" do
    field :has_played, :boolean, default: false
    field :is_host, :boolean, default: false
    field :song_id, :string
    belongs_to :member, AuxApi.Member
    belongs_to :session, AuxApi.Session

    timestamps()
  end

  @doc false
  def changeset(qentry, attrs) do
    qentry
    |> cast(attrs, [:is_host, :song_id, :has_played])
    |> validate_required([:is_host, :song_id, :has_played])
  end
end
