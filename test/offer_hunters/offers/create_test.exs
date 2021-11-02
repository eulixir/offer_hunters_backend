defmodule OfferHunters.Offers.CreateTest do
  @moduledoc """
    Tests for create offer module
  """
  use OfferHunters.DataCase, async: true

  import OfferHunters.Factory

  alias OfferHunters.{Error, User, Offer, Offers.Create}

  describe "call/1" do
    test "When all params are valid, creates the user" do
      %User{id: user_id, email: email} = insert(:user)

      {:ok,
       %Offer{
         id: id,
         description: description,
         expiration_date: expiration_date,
         image: image,
         promotion_link: promotion_link
       } = response} =
        :offer_item
        |> build()
        |> Create.call(email)

      assert {:ok,
              %OfferHunters.Offer{
                description: ^description,
                expiration_date: ^expiration_date,
                id: ^id,
                image: ^image,
                promotion_link: ^promotion_link,
                user_id: ^user_id
              }} = {:ok, response}
    end

    test "When email not exist, returns an error" do
      response =
        :offer_item
        |> build()
        |> Create.call("jp@banana.com")

      assert {:error, %Error{result: "Email does not exist", status: :not_found}} ==
               response
    end

    test "When as missing params, returns an error" do
      %User{email: email} = insert(:user)

      response = Create.call(%{}, email)

      assert {:error,
              %Error{
                result: %{
                  changes: %{},
                  errors: [
                    description: {"can't be blank", [validation: :required]},
                    promotion_link: {"can't be blank", [validation: :required]},
                    image: {"can't be blank", [validation: :required]},
                    expiration_date: {"can't be blank", [validation: :required]},
                    value: {"can't be blank", [validation: :required]}
                  ],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
