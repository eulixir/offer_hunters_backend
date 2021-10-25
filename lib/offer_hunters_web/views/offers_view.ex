defmodule OfferHuntersWeb.OfferView do
  use OfferHuntersWeb, :view

  def render("created.json", %{offer: offer}), do: %{offer: offer}
end
