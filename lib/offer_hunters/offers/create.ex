defmodule OfferHunters.Offers.Create do
  @moduledoc """
    Inserts an offer into database
  """
  alias OfferHunters.{Error, Offer, Repo, User}

  @doc """
  Recive the email and seacrh this into the database.

  ## Examples
  iex> OfferHunters.Offers.Create.call(
      %{
        description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
        expiration_date: "2019-15-10",
        image: "src/banana",
        promotion_link: "https://www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-
        10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#banana",
        value: 10999.0
      }, "jp@banana.com")
        {:ok,
          %OfferHunters.Offer{
            __meta__: #Ecto.Schema.Metadata<:loaded, "offers">,
            description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
            expiration_date: "2019-15-10",
            id: "8dfe7055-f02e-43e4-9544-911668f1d769",
            image: "src/banana",
            inserted_at: ~N[2021-10-31 00:48:34],
            promotion_link: "https://www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486",
            updated_at: ~N[2021-10-31 00:48:34],
            user: #Ecto.Association.NotLoaded<association :user is not loaded>,
            user_id: "a66d859c-b3e4-4482-8460-615d97f91eab",
            value: #Decimal<10999.0>
          }}

  iex> OfferHunters.Offers.Create.call(
      %{
        description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
        expiration_date: "2019-15-10",
        image: "src/banana",
        promotion_link: "https://www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-
        10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#banana",
        value: 10999.0
      }, "jp@banana.com")
        {:error,
          %OfferHunters.Error{
            result: #Ecto.Changeset<
              action: :insert,
              changes: %{
                description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
                expiration_date: "2019-15-10",
                image: "src/banana",
                promotion_link: "https://www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#banana",
                user_id: "a66d859c-b3e4-4482-8460-615d97f91eab",
                value: #Decimal<10999.0>
              },
              errors: [
                promotion_link: {"has already been taken",
                  [constraint: :unique, constraint_name: "offers_promotion_link_index"]}
              ],
              data: #OfferHunters.Offer<>,
              valid?: false
            >,
            status: :bad_request
          }}

  """
  @spec call(
          %{
            description: String.t(),
            promotion_link: String.t(),
            image: bitstring(),
            expiration_date: Date.t(),
            value: Decimal.t()
          },
          String.t()
        ) ::
          {:ok, %Offer{}}
          | {:error, %OfferHunters.Error{result: String.t(), status: :bad_request}}

  def call(
        %{
          description: _description,
          promotion_link: _promotion_link,
          image: _image,
          expiration_date: _expiration_date,
          value: _value
        } = params,
        email
      ) do
    email
    |> OfferHunters.get_user_by_email()
    |> handle_get_email(params)
  end

  defp handle_get_email({:error, reason}, _params), do: {:error, reason}

  defp handle_get_email({:ok, %User{id: id}}, params), do: create_offer(params, id)

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
