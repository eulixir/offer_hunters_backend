defmodule OfferHuntersWeb.CommentView do
  use OfferHuntersWeb, :view

  def render("created.json", %{comment: comment, name: name, created_date: created_date}),
    do: %{comment: comment, name: name, created_date: created_date}
end
