defmodule OfferHunters.Offers.Delete do
  @moduledoc """
    Module for delete Offer
  """
  alias OfferHunters.{Error, Offer, Repo}

  def call(id) do
    case Repo.get(Offer, id) do
      nil -> {:error, Error.build(:not_found, "This offer doesn't exist'")}
      offer -> Repo.delete(offer)
    end
  end
end
