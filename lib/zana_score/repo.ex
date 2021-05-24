defmodule ZanaScore.Repo do
  use Ecto.Repo,
    otp_app: :zana_score,
    adapter: Ecto.Adapters.Postgres
end
