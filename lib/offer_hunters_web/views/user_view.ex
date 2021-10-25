defmodule OfferHuntersWeb.UserView do
  use OfferHuntersWeb, :view

  def render("created.json", %{user: user}), do: %{user: user}

  def render("show.json", %{user: user}), do: %{user: user}

  def render("deleted.json", %{email: email}),
    do: %{message: "The user #{email} has been deleted"}
end
