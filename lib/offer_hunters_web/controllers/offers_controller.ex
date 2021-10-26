defmodule OfferHuntersWeb.OfferController do
  use OfferHuntersWeb, :controller

  alias OfferHunters.Offer

  action_fallback OfferHuntersWeb.FallbackController

  def create(conn, %{
        "description" => description,
        "promotion_link" => promotion_link,
        "image" => image,
        "expiration_date" => expiration_date,
        "value" => value,
        "email" => email
      }) do
    with {:ok, %Offer{} = offer} <-
           OfferHunters.create_offer(
             %{
               description: description,
               promotion_link: promotion_link,
               image: image,
               expiration_date: expiration_date,
               value: value
             },
             email
           ) do
      conn
      |> put_status(:created)
      |> render("created.json", offer: offer)
    end
  end
end
