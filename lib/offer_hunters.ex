defmodule OfferHunters do
  @moduledoc """
    Fachade to turn application more fexible and more friendly to developer
  """
  alias OfferHunters.Comments.Create, as: CommentsCreate
  alias OfferHunters.Comments.Delete, as: CommentsDelete
  alias OfferHunters.Comments.Get, as: CommentsGet

  alias OfferHunters.Offers.Create, as: OffersCreate
  alias OfferHunters.Offers.Delete, as: OffersDelete
  alias OfferHunters.Offers.Get, as: OffersGet
  alias OfferHunters.Offers.Update, as: OffersUpdate

  alias OfferHunters.Users.Create, as: UsersCreate
  alias OfferHunters.Users.Get, as: UsersGet

  defdelegate create_comment(params), to: CommentsCreate, as: :call

  defdelegate delete_comment_by_id(id), to: CommentsDelete, as: :call

  defdelegate get_comment_by_id(id), to: CommentsGet, as: :by_id

  defdelegate create_user(params), to: UsersCreate, as: :call

  defdelegate get_all_users(), to: UsersGet, as: :all_users

  defdelegate get_user_by_email(params), to: UsersGet, as: :by_email

  defdelegate get_user_by_id(id), to: UsersGet, as: :by_id

  defdelegate create_offer(params, email), to: OffersCreate, as: :call

  defdelegate get_offer_by_query(params), to: OffersGet, as: :by_query

  defdelegate get_offer_by_id(params), to: OffersGet, as: :by_id

  defdelegate delete_offer_by_id(id), to: OffersDelete, as: :call

  defdelegate verify_offer(id), to: OffersUpdate, as: :verify_offer
end
