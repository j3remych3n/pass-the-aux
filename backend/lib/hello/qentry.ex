defmodule Hello.Qentry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "qentries" do
    field :has_played, :boolean, default: false
    field :is_host, :boolean, default: false
    field :song_id, :string
    field :session_id, :id
    field :member_id, :id
    field :next_qentry_id, :id
    field :prev_qentry_id, :id

    timestamps()
  end

  @doc false
  def changeset(qentry, attrs) do
    qentry
    |> cast(attrs, [:is_host, :song_id, :has_played])
    |> validate_required([:is_host, :song_id, :has_played])
  end
end
