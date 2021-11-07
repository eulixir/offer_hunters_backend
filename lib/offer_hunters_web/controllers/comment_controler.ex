defmodule OfferHuntersWeb.CommentController do
  use OfferHuntersWeb, :controller

  alias OfferHunters.{Comment, Offer, User}

  action_fallback OfferHuntersWeb.FallbackController

  def create(
        conn,
        %{
          "comment" => comment,
          "name" => name,
          "offer_id" => offer_id,
          "user_id" => user_id,
          "created_date" => created_date
        } = params
      ) do
    with {:ok, %Offer{}} <- OfferHunters.get_offer_by_id(offer_id),
         {:ok, %User{}} <- OfferHunters.get_user_by_id(user_id),
         {:ok, %Comment{id: id}} <- OfferHunters.create_comment(params) do
      conn
      |> put_status(:created)
      |> render("created.json", comment: comment, name: name, created_date: created_date, id: id)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _comment} <-
           OfferHunters.get_comment_by_id(id) do
      OfferHunters.delete_comment_by_id(id)

      conn
      |> put_status(:ok)
      |> render("comment.json", comment: "Comment deleted!")
    end
  end
end
