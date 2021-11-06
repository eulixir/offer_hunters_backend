defmodule OfferHuntersWeb.CommentController do
  use OfferHuntersWeb, :controller

  alias OfferHunters.{Comment, Offer, User}

  action_fallback OfferHuntersWeb.FallbackController

  def create(
        conn,
        %{
          "comment" => comment,
          "offer_id" => offer_id,
          "user_id" => user_id
        } = params
      ) do
    with {:ok, %Offer{}} <- OfferHunters.get_offer_by_id(offer_id),
         {:ok, %User{}} <- OfferHunters.get_user_by_id(user_id),
         {:ok, %Comment{}} <- OfferHunters.create_comment(params) do
      conn
      |> put_status(:created)
      |> render("created.json", comment: comment)
    end
  end
end
