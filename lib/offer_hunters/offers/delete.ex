defmodule OfferHunters.Offers.Delete do
  @moduledoc """
    Module for delete Offer
  """
  alias OfferHunters.{Offer, Repo}

  def call(id) do
    id
    |> OfferHunters.get_offer_by_id()
    |> handle_delete()
  end

  defp handle_delete({:ok, %Offer{id: id}}), do: Repo.delete(id)

  defp handle_delete({:error, reason}), do: {:error, reason}
end
