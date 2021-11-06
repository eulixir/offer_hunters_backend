defmodule OfferHunters.Offers.Update do
  @moduledoc """
  Module for update offer
  """
  alias OfferHunters.{Error, Offer, Repo}

  def verify_offer(id) do
    Offer
    |> Repo.get(id)
    |> handle_update()
  end

  defp handle_update(nil), do: {:error, Error.build(:not_found, "This offer doesn't exist")}

  defp handle_update(offer) do
    offer
    |> Offer.changeset(%{valid: true})
    |> Repo.update()

    {:ok, Repo.preload(Repo.get(Offer, offer.id), [:user, :comments])}
  end
end
