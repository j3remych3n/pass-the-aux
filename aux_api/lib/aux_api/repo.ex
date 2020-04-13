defmodule AuxApi.Repo do
  use Ecto.Repo,
    otp_app: :aux_api,
    adapter: Ecto.Adapters.Postgres
end
