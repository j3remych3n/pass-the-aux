import Ecto.Query
import Ecto.Changeset
import AuxApi.AuxLibrary
alias AuxApi.Repo

defmodule AuxApiWeb.TestController do
	use AuxApiWeb, :controller

	def find_neighbor_qentries(conn, %{qentry_id: qentry_id}) do
		{prev, next} = find_neighbor_qentries(qentry_id)
		json(conn, %{prev: prev, next: next})
	end

	defp mark_played(member_id, session_id, qentry_id) do
		get_neighbors = from q in "qentries",
			where: (q.id == ^qentry_id),
			select: {q.prev_qentry_id, q.next_qentry_id}
		if not is_nil(qentry_id) do
			{prev, next} = List.first(Repo.all(get_neighbors))

			if not is_nil(prev) do
				from(q in "qentries", where: q.id == ^prev, update: [set: [next_qentry_id: ^next]])
        |> Repo.update_all([])
			end

			if not is_nil(next) do
				from(q in "qentries", where: q.id == ^next, update: [set: [prev_qentry_id: ^prev]])
        |> Repo.update_all([])
			end

			{last_played, _} = find_last_qentry(member_id, session_id, true)
			if not is_nil(last_played) do
				from(q in "qentries", where: q.id == ^last_played, update: [set: [next_qentry_id: ^qentry_id,]])
				|> Repo.update_all([])
			end
			from(q in "qentries", where: q.id == ^qentry_id,
				update: [
					set: [
						played: true,
						next_qentry_id: nil,
						prev_qentry_id: ^last_played,
					]])
			|> Repo.update_all([])
			# not_played = "empty"
			# if not is_nil(next) do
			# 	not_played = print_qentry_order(next, Integer.to_string(next) <> " ")
			# 	played = print_qentry_order_backwards(qentry_id, Integer.to_string(qentry_id) <> " ")
			# 	"played: " <> played <> "\nnot played: " <> not_played
			# else
			# 	played = print_qentry_order_backwards(qentry_id, Integer.to_string(qentry_id) <> " ")
			# 	song_id, "played: " <> played <> "\nnot played: " <> not_played
			# end

			get_next_song = from qentry in "qentries",
				where: (qentry.id == ^next),
				select: qentry.song_id
			List.first(Repo.all(get_next_song))
		end
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
