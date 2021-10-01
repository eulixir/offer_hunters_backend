defmodule OfferHuntersWeb.HomeController do
  use OfferHuntersWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("home.json", message: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")
  end
end
