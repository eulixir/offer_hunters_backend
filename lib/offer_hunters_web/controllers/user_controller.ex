defmodule OfferHuntersWeb.UserController do

  use OfferHuntersWeb, :controller

  alias OfferHunters.User

  action_fallback OfferHuntersWeb.FallbackController

  def create(conn, %{"email" => email, "name" => name, "profile_picture" => profile_picture}) do
    with {:ok, %User{} = user} <- OfferHunters.create_user(%{"email" => email, "name" => name, "profile_picture" => profile_picture}) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end
end
