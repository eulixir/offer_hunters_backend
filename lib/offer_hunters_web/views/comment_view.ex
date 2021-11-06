defmodule OfferHuntersWeb.CommentView do
  use OfferHuntersWeb, :view

  def render("created.json", %{comment: comment}), do: %{comment: comment}

  def render("comment.json", %{comment: comment}), do: %{comment: comment}

  def render("deleted.json", %{email: email}),
    do: %{message: "The comment #{email} has been deleted"}
end
