defmodule OfferHuntersWeb.OfferView do
  use OfferHuntersWeb, :view

  def render("created.json", %{offer: offer}), do: %{offer: offer}

  def render("offer.json", %{offer: offer}), do: %{offer: offer}

  def render("offers.json", %{offers: offers}), do: %{offers: offers}
end
