import Ecto.Query
alias AuxApi.Repo

defmodule AuxApi.DbActions do
  def get_songs_recursive(qentry_id, tracker) do
    {next_id, next_song_id} = find_song(find_next_qentry(qentry_id))

    if is_nil(next_id) do
      tracker
    else
      get_songs_recursive(next_id, tracker ++ [[next_id, next_song_id]])
    end
  end

  def find_song(qentry_id) when is_nil(qentry_id), do: {nil, nil}
  def find_song(qentry_id) when not is_nil(qentry_id) do
    query =
      from qentry in "qentries",
        where: qentry.id == ^qentry_id,
        select: {qentry.id, qentry.song_id}

    List.first(Repo.all(query))
  end

  def find_prev_qentry(qentry_id) when is_nil(qentry_id), do: nil

  def find_prev_qentry(qentry_id) when not is_nil(qentry_id) do
    query =
      from qentry in "qentries",
        where: qentry.id == ^qentry_id,
        select: qentry.prev_qentry_id

    List.first(Repo.all(query))
  end

  def swap_qentries(qid_one, qid_two) do
    update_prev_qentry(qid_one, qid_two)
    update_next_qentry(qid_two, qid_one)
  end

  def find_next_qentry(qentry_id) when is_nil(qentry_id), do: nil

  def find_next_qentry(qentry_id) when not is_nil(qentry_id) do
    query =
      from qentry in "qentries",
        where: qentry.id == ^qentry_id,
        select: qentry.next_qentry_id

    List.first(Repo.all(query))
  end

  def find_neighbor_qentries(qentry_id) when is_nil(qentry_id), do: {nil, nil}

  def find_neighbor_qentries(qentry_id) when not is_nil(qentry_id) do
    query =
      from qentry in "qentries",
        where: qentry.id == ^qentry_id,
        select: {qentry.prev_qentry_id, qentry.next_qentry_id}

    List.first(Repo.all(query))
  end

  def update_prev_qentry(qentry_id, _) when is_nil(qentry_id), do: nil

  def update_prev_qentry(qentry_id, prev_id) when not is_nil(qentry_id) do
    from(q in "qentries", where: q.id == ^qentry_id, update: [set: [prev_qentry_id: ^prev_id]])
    |> Repo.update_all([])
  end

  def update_next_qentry(qentry_id, _) when is_nil(qentry_id), do: nil

  def update_next_qentry(qentry_id, next_id) when not is_nil(qentry_id) do
    from(q in "qentries", where: q.id == ^qentry_id, update: [set: [next_qentry_id: ^next_id]])
    |> Repo.update_all([])
  end

  def find_first_qentry(member_id, session_id, played \\ false) do
    find_lonely_qentry(member_id, session_id, played, true)
  end

  def find_last_qentry(member_id, session_id, played \\ false) do
    find_lonely_qentry(member_id, session_id, played, false)
  end

  def mark_played(_, _, qentry_id) when is_nil(qentry_id), do: nil

  def mark_played(member_id, session_id, qentry_id) when not is_nil(qentry_id) do
    {prev, next} = find_neighbor_qentries(qentry_id)
    update_next_qentry(prev, next)
    update_prev_qentry(next, prev)

    {last_played, _} = find_last_qentry(member_id, session_id, true)
    update_next_qentry(last_played, qentry_id)

    from(q in "qentries",
      where: q.id == ^qentry_id,
      update: [
        set: [
          played: true,
          next_qentry_id: nil,
          prev_qentry_id: ^last_played
        ]
      ]
    )
    |> Repo.update_all([])

    find_song(next)
  end

  defp find_lonely_qentry(member_id, session_id, played, first)
       when is_nil(member_id) or
              is_nil(session_id) or
              is_nil(played) or
              is_nil(first),
       do: {nil, nil}

  defp find_lonely_qentry(member_id, session_id, played, first) do
    query =
      from qentry in "qentries",
        where:
          qentry.member_id == ^member_id and
            qentry.session_id == ^session_id and
            qentry.played == ^played and
            ((^first and is_nil(qentry.prev_qentry_id)) or
               (not (^first) and is_nil(qentry.next_qentry_id))),
        select: {qentry.id, qentry.song_id}

    res = List.first(Repo.all(query))
    if is_nil(res), do: {nil, nil}, else: res
  end

  def find_member(spotify_uid) when is_nil(spotify_uid), do: nil

  def find_member(spotify_uid) when not is_nil(spotify_uid) do
    query =
      from member in "members",
        where: member.spotify_uid == ^spotify_uid,
        select: member.id

    member_result = Repo.all(query)

    case length(member_result) do
      1 -> List.first(member_result)
      _ -> nil
    end
  end
end
