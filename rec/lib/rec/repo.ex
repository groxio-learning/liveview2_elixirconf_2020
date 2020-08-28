defmodule Rec.Repo do
  use Ecto.Repo,
    otp_app: :rec,
    adapter: Ecto.Adapters.Postgres
end
