 defmodule OfferHuntersWeb.UserView do

  use OfferHuntersWeb, :view

  def render("created.json", %{user: user}), do: %{user: user}

  def render("show.json", %{user: user}), do: %{user: user}

  def render("deleted.json", %{user_email: user_email}),
    do: %{message: "The user #{user_email} has been deleted"}
 end
