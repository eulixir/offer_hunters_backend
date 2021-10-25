defmodule OfferHunters do
  @moduledoc """
    Fachade to turn application more fexible and more friendly to developer
  """

  alias OfferHunters.Offers.Create, as: OffersCreate
  alias OfferHunters.Users.Create, as: UsersCreate

  defdelegate create_user(params), to: UsersCreate, as: :call

  defdelegate create_offer(params, email), to: OffersCreate, as: :call
end
