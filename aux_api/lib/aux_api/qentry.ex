defmodule AuxApi.Qentry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "qentries" do
    field :song_id, :string

    field :played, :boolean, default: false
    field :next_qentry_id, :integer
    field :prev_qentry_id, :integer

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
