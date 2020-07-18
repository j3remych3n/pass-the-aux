import Ecto.Query
import AuxApi.DbActions
alias AuxApi.Repo

defmodule AuxApiWeb.QueueChannel do
  require Logger
  use AuxApiWeb, :channel

  def join("queue:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    # check member_id and spotify_uid pair match in DB
    true
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in(
        "add_song",
        %{"member_id" => member_id, "session_id" => session_id, "song_id" => song_id},
        socket
      ) do
    {prev_qentry_id, _} = find_last_qentry(member_id, session_id)

    {:ok, test_qentry} =
      %AuxApi.Qentry{
        song_id: song_id,
        session_id: session_id,
        member_id: member_id,
        played: false,
        next_qentry_id: nil,
        prev_qentry_id: prev_qentry_id
      }
      |> Repo.insert()

    update_next_qentry(prev_qentry_id, test_qentry.id)
    {:reply, :ok, socket}
  end

  # TODO -> REFACTOR -> member_id from presence / auth ; session_id from subtopic
  def handle_in(
        "change_pos",
        %{
          "member_id" => member_id,
          "session_id" => session_id,
          "qentry_id" => curr_id,
          "new_prev_id" => new_prev_id
        },
        socket
      ) do
    # link this qentry's previous and next (== remove this qentry)
    # curr.prev.next = curr.next
    # curr.next.prev = curr.prev
    {curr_prev_id, curr_next_id} = find_neighbor_qentries(curr_id)

    unless new_prev_id == curr_prev_id do
      swap_qentries(curr_next_id, curr_prev_id)
      # curr.next = new_prev.next
      if is_nil(new_prev_id) do
        # song needs to go to front of the queue
        {new_next_id, _} = find_first_qentry(member_id, session_id)
        swap_qentries(new_next_id, curr_id)
      else
        # song is now in the middle somewhere, or at the end
        {_, new_next_id} = find_neighbor_qentries(new_prev_id)
        swap_qentries(new_next_id, curr_id)
      end

      # curr.prev = new_prev
      # new_prev.next = curr
      swap_qentries(curr_id, new_prev_id)
    end

    # TODO: update with proper response
    {:reply, :ok, socket}
  end

  def handle_in("delete_song", %{"qentry_id" => qentry_id}, socket) do
    # song could be: beginning, middle, end
    # this should be fine with the two linkedlists approach, no edits
    {prev_qentry_id, next_qentry_id} = find_neighbor_qentries(qentry_id)
    swap_qentries(next_qentry_id, prev_qentry_id)
    from(q in "qentries", where: q.id == ^qentry_id) |> Repo.delete_all()
    # TODO: update with proper response
    {:reply, :ok, socket}
  end

  # TODO -> REFACTOR -> member_id from presence / auth ; session_id from subtopic
  def handle_in("get_songs", %{"member_id" => member_id, "session_id" => session_id}, socket) do
    {qentry_id, song_id} = find_first_qentry(member_id, session_id)
    tracker = get_songs_recursive(qentry_id, [[qentry_id, song_id]])

    push(socket, "get_songs", %{songs: tracker})
    {:reply, {:ok, %{songs: tracker}}, socket}
  end

  # TODO -> REFACTOR -> member_id from presence / auth ; session_id from subtopic
  def handle_in("leave_sess", %{"member_id" => member_id, "session_id" => session_id}, socket) do
    from(q in "qentries", where: q.member_id == ^member_id and q.session_id == ^session_id)
    |> Repo.delete_all()

    {:reply, :ok, socket}
  end

  # TODO -> REFACTOR -> member_id from presence / auth ; session_id from subtopic
  def handle_in("next", %{"member_id" => member_id, "session_id" => session_id}, socket) do
    {qentry, _} = find_first_qentry(member_id, session_id)

    if is_nil(qentry) do
      {:reply, {:ok, %{info: "no songs in queue"}}, socket}
    else
      song_id = mark_played(member_id, session_id, qentry)
      {:reply, {:ok, %{qentry_id: qentry, song_id: song_id}}, socket}
    end
  end
end
