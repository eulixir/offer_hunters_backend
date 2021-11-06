defmodule OfferHunters.Offers.Update do
  alias OfferHunters.{Error, Repo, Offer}

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

    {:ok, Repo.preload(Repo.get(Offer, offer.id), :user)}
  end
end
