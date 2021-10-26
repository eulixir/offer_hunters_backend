defmodule OfferHunters.Offers.Get do
  @moduledoc """
    Get offers
  """

  import Ecto.Query

  alias OfferHunters.{Error, Offer, Repo}

  def by_query(params) do
    {:ok, Repo.all(from o in Offer, where: like(o.description, ^"%#{params}%"))}
  end

  def by_id(id) do
    case Repo.get(Offer, id) do
      %Offer{} = offer -> {:ok, offer}
      nil -> {:error, Error.build(:bad_request, "Offer is not available")}
    end
  end
end
