defmodule Work.Repo do
  use Ecto.Repo,
    otp_app: :work,
    adapter: Ecto.Adapters.Postgres
end
