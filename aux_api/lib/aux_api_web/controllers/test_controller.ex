import Ecto.Query
import AuxApi.DbActions
alias AuxApi.Repo

defmodule AuxApiWeb.TestController do
	use AuxApiWeb, :controller

	def get_neighbor_qentries(conn, %{"qentry_id"=> qid}) do
		qentry_id = String.to_integer(qid)
		{prev, next} = find_neighbor_qentries(qentry_id)
		json(conn, %{prev: "a", next: "b"})
	end

	def add_song(conn, %{"member_id" => mid, "session_id" => seid, "song_id" => song_id}) do
		member_id = String.to_integer(mid)
    session_id = String.to_integer(seid)

		{prev_qentry_id, _} = find_last_qentry(member_id, session_id)

    qentry = %AuxApi.Qentry{
      song_id: song_id,
      session_id: session_id,
      member_id: member_id,
      next_qentry_id: nil,
      prev_qentry_id: prev_qentry_id,
    }

		{:ok, test_qentry} = Repo.insert(qentry)

		update_next_qentry(prev_qentry_id, test_qentry.id)
		json(conn, %{txt: "kk"})
	end

	def next(conn, %{"member_id" => mid, "session_id" => sid}) do
		member = String.to_integer(mid)
		session = String.to_integer(sid)

		{qentry, _} = find_first_qentry(member, session)
		if is_nil(qentry) do
			json(conn, %{info: "no songs in queue"})
		else
			{_, song_id} = mark_played(member, session, qentry)
			json(conn, %{qentry_id: qentry, song_id: song_id})
		end
	end

	def test_private_func(conn, %{"member_id" => mid, "session_id" => sid}) do
		member = String.to_integer(mid)
		session = String.to_integer(sid)

		{first, _} = find_first_qentry(member, session)
		{last, _} = find_last_qentry(member, session)

		forwards = print_qentry_order(first, Integer.to_string(first) <> " ")
		backwards = print_qentry_order_backwards(last, Integer.to_string(last) <> " ")
		text(conn, forwards <> "\n" <> backwards)
	end

	defp print_qentry_order(curr_id, tracker) do
		next_id = find_next_qentry(curr_id)
		if is_nil(next_id) do
			tracker
		else
			print_qentry_order(next_id, tracker <> Integer.to_string(next_id) <> " ")
		end
	end

	defp print_qentry_order_backwards(curr_id, tracker) do
		prev_id = find_prev_qentry(curr_id)
		if is_nil(prev_id) do
			tracker
		else
			print_qentry_order_backwards(prev_id, tracker <> Integer.to_string(prev_id) <> " ")
		end
	end
end
