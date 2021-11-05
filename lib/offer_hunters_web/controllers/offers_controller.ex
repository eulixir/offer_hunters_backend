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

  def get_by_id(conn, %{"id" => id}) do
    with {:ok, offer} <-
           OfferHunters.get_offer_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("offer.json", offer: offer)
    end
  end

  def get_by_query(conn, %{"label" => params}) do
    with {:ok, offers} <-
           OfferHunters.get_offer_by_query(params) do
      conn
      |> put_status(:ok)
      |> render("offers.json", offers: offers)
    end
  end

  def delete_by_id(conn, %{"id" => id}) do
    with {:ok, _offer} <-
           OfferHunters.get_offer_by_id(id) do
      OfferHunters.delete_offer_by_id(id)

      conn
      |> put_status(:ok)
      |> render("offer", offer: "Offer deleted!")
    end
  end
end
