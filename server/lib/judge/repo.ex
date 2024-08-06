defmodule Judge.Repo do
  use Ecto.Repo,
    otp_app: :judge,
    adapter: Ecto.Adapters.Postgres
end
