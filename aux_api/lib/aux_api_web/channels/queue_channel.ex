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

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    sess = %AuxApi.Session{}
    {:ok, curr_sess} = AuxApi.Repo.insert(sess)
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (queue:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("add_song", payload, socket) do
    # payload: str: member_id, str: queue_id, str: spotify_uri
    # generate previous song id by filtering for qentry where next is null (same member and queue id)
    # insert

    song = %AuxApi.Qentry{
      member_id: 1, # passed in
      session_id: 1, # pull from subtopic
      next_qentry_id: 1, # null
      prev_qentry_id: 1, # gen by filter
      has_played: false, 
      is_host: false, 
      song_id: "temp" # passed in
    }

    {:ok, } = AuxApi.Repo.insert(song)
    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
