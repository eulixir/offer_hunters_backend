defmodule OfferHuntersWeb.FallbackController do
  @moduledoc """
  false
  """
  use OfferHuntersWeb, :controller

  alias OfferHunters.Error
  alias OfferHuntersWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
