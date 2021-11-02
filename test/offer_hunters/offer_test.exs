defmodule OfferHunters.OfferTest do
  @moduledoc """
    Tests for offer Schema
  """
  use OfferHunters.DataCase, async: true

  import OfferHunters.Factory

  alias Ecto.Changeset

  alias OfferHunters.Offer

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset" do
      response =
        :offer_params
        |> build()
        |> Offer.changeset()

      assert %Changeset{
               changes: %{
                 description: "Placa de vídeo Galax GeForce RTX 3080 HOF",
                 expiration_date: "2019-15-10",
                 image: "src/banana",
                 promotion_link:
                   "https =>//www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#banana",
                 user_id: "a66d859c-b3e4-4482-8460-615d97f91eab"
               },
               valid?: true
             } = response
    end
  end

  test "When any fields as empty, returns an error" do
    response = Offer.changeset(%{})

    assert %Changeset{
             changes: %{},
             errors: [
               description: {"can't be blank", [validation: :required]},
               promotion_link: {"can't be blank", [validation: :required]},
               image: {"can't be blank", [validation: :required]},
               expiration_date: {"can't be blank", [validation: :required]},
               value: {"can't be blank", [validation: :required]},
               user_id: {"can't be blank", [validation: :required]}
             ],
             valid?: false
           } = response
  end
end
