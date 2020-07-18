import Ecto.Query
import Ecto.Changeset
alias AuxApi.Repo
import AuxApi.DbActions

defmodule AuxApiWeb.MemberController do
  use AuxApiWeb, :controller

  def auth_member(conn, %{"spotify_uid" => spotify_uid}) do
    # member_id = find_member(spotify_uid)
    member_id = nil # TODO TEMPORARY

    if is_nil(member_id) do
      {:ok, member} = %AuxApi.Member{spotify_uid: spotify_uid} |> Repo.insert()
      json(conn, %{auth_token: member.id})
    else
      json(conn, %{auth_token: member_id})
    end
  end

  def delete_member(conn, %{"spotify_uid" => spotify_uid, "member_id" => mid}) do
    member_id = String.to_integer(mid)

    if member_id == find_member(spotify_uid) do
      from(member in "members", where: member.id == ^member_id) |> Repo.delete_all()
      conn |> put_status(200) |> json(%{})
    else
      conn |> put_status(403) |> json(%{error: "invalid authentication / member does not exist"})
    end
  end
end
