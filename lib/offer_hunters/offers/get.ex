defmodule OfferHunters.Offers.Get do
  @moduledoc """
    Get offers
  """

  import Ecto.Query

  alias OfferHunters.{Error, Offer, Repo}

  def by_query(params) do
    {:ok,
     Repo.preload(Repo.all(from o in Offer, where: like(o.description, ^"%#{params}%")), :user)}
  end

  def by_id(id) do
    case Repo.preload(Repo.get(Offer, id), :user) do
      %Offer{} = offer -> {:ok, offer}
      nil -> {:error, Error.build(:bad_request, "Offer is not exist")}
    end
  end
end
