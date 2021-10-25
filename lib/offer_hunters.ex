defmodule OfferHunters do
  @moduledoc """
    Fachade to turn application more fexible and more friendly to developer
  """

  alias OfferHunters.Offers.Create, as: OffersCreate
  alias OfferHunters.Users.Create, as: UsersCreate
  alias OfferHunters.Users.Get, as: UsersGet

  defdelegate create_user(params), to: UsersCreate, as: :call

  defdelegate get_all_users(), to: UsersGet, as: :get_all_users

  defdelegate get_by_email(params), to: UsersGet, as: :get_by_email

  defdelegate create_offer(params, email), to: OffersCreate, as: :call
end
