defmodule OfferHuntersWeb.HomeView do
  use OfferHuntersWeb, :view

  def render("home.json", %{message: message}), do: %{message: message}
end
