defmodule OfferHunters.Repo do
  use Ecto.Repo,
    otp_app: :offer_hunters,
    adapter: Ecto.Adapters.Postgres
end
