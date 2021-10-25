defmodule OfferHunters.Offers.Create do
  @moduledoc """
    Inserts an offer into database
  """
  alias OfferHunters.{Offer, Repo, User}

  alias OfferHunters.Error

  def call(
        %{
          product: _product,
          description: _description,
          promotion_link: _promotion_link,
          image: _image,
          expiration_date: _expiration_date,
          value: _value
        } = params,
        email
      ) do
    case OfferHunters.get_by_email(email) do
      {:ok, %User{id: id}} ->
        create_offer(params, id)

      {:error, "Email does not exist"} ->
        {:error, Error.build(:not_found, "Email does not exist")}
    end
  end

  defp create_offer(params, id) do
    params
    |> Map.put(:user_id, id)
    |> Offer.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Offer{}} = result), do: result

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
