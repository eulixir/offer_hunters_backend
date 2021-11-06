defmodule OfferHunters.Offers.Get do
  @moduledoc """
    Get offers
  """

  import Ecto.Query

  alias OfferHunters.{Error, Offer, Repo}

  @doc """
    Recive the params for query and return a offers conating the terms of query

    iex> OfferHunters.Offers.Get.by_query("RTX 3080")
    {:ok,
      [
        %OfferHunters.Offer{
          __meta__: #Ecto.Schema.Metadata<:loaded, "offers">,
          description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
          expiration_date: "2019-15-10",
          id: "abf9578c-851d-48fe-901f-655ab29d8882",
          image: "src/banana",
          inserted_at: ~N[2021-10-26 13:39:54],
          promotion_link: "https://www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#",
          updated_at: ~N[2021-10-26 13:39:54],
          user: %OfferHunters.User{
            __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
            email: "jp@banana.com",
            id: "a66d859c-b3e4-4482-8460-615d97f91eab",
            inserted_at: ~N[2021-10-26 13:39:48],
            name: "Jp",
            offers: #Ecto.Association.NotLoaded<association :offers is not loaded>,
            profile_picture: "src/banana",
            updated_at: ~N[2021-10-26 13:39:48]
          },
          user_id: "a66d859c-b3e4-4482-8460-615d97f91eab",
          value: #Decimal<10999.0>
        },
      ]

      Obs: When de fild of query is empty, return all offers (caution to use this function 😄)

  """
  @spec by_query(String.t()) :: {:ok, list()}
  def by_query(params) do
    {:ok,
     Repo.preload(Repo.all(from o in Offer, where: like(o.description, ^"%#{params}%")), [
       :comments,
       :user
     ])}
  end

  @doc """
  Recive the id and search into database a offer containing this id

  iex> OfferHunters.Offers.Get.by_id("abf9578c-851d-48fe-901f-655ab29d8882")
        {:ok,
          %OfferHunters.Offer{
            __meta__: #Ecto.Schema.Metadata<:loaded, "offers">,
            description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
            expiration_date: "2019-15-10",
            id: "abf9578c-851d-48fe-901f-655ab29d8882",
            image: "src/banana",
            inserted_at: ~N[2021-10-26 13:39:54],
            promotion_link: "https://www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#",
            updated_at: ~N[2021-10-26 13:39:54],
            user: %OfferHunters.User{
              __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
              email: "jp@banana.com",
              id: "a66d859c-b3e4-4482-8460-615d97f91eab",
              inserted_at: ~N[2021-10-26 13:39:48],
              name: "Jp",
              offers: #Ecto.Association.NotLoaded<association :offers is not loaded>,
              profile_picture: "src/banana",
              updated_at: ~N[2021-10-26 13:39:48]
            },
            user_id: "a66d859c-b3e4-4482-8460-615d97f91eab",
            value: #Decimal<10999.0>
      }}

    iex> OfferHunters.Offers.Get.by_id("invalid id")
         {:error, %OfferHunters.Error{result: "This offer doesn't exist", status: :bad_request}}
  """
  @spec by_id(String.t()) ::
          {:ok, %Offer{}} | {:error, %Error{result: String.t(), status: :bad_request}}
  def by_id(id) do
    case Repo.preload(Repo.get(Offer, id), [:user, :comments]) do
      %Offer{} = offer -> {:ok, offer}
      nil -> {:error, Error.build(:bad_request, "This offer doesn't exist")}
    end
  end
end
