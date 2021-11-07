defmodule OfferHuntersWeb.CommentView do
  use OfferHuntersWeb, :view

  def render("created.json", %{comment: comment, name: name, created_date: created_date, id: id}),
    do: %{comment: comment, name: name, created_date: created_date, id: id}

  def render("comment.json", %{comment: comment}), do: %{comment: comment}
end
