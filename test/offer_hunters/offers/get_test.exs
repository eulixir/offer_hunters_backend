defmodule OfferHunters.Offers.GetTest do
  @moduledoc """
    Tests for get user module
  """
  use OfferHunters.DataCase, async: true

  import OfferHunters.Factory

  alias OfferHunters.{Offer, Offers.Get, User}

  describe "by_query/1" do
    test "When the terms on query exsists, returns a list of offers" do
      %User{id: user_id, email: email} = insert(:user)
      insert(:offer, user_id: user_id)

      {:ok,
       [
         %Offer{
           description: description,
           id: id,
           image: image,
           promotion_link: promotion_link,
           user: user
         }
       ] = response} = Get.by_query("RTX 3080")

      assert {:ok,
              [
                %Offer{
                  description: ^description,
                  id: ^id,
                  image: ^image,
                  promotion_link: ^promotion_link,
                  user: ^user
                }
              ]} = {:ok, response}
    end

    test "When the field of query is empty, return all offers" do
      %User{id: user_id} = insert(:user)
      insert(:offer, user_id: user_id)

      {:ok,
       [
         %Offer{
           description: description,
           id: id,
           image: image,
           promotion_link: promotion_link,
           user: user
         }
       ] = response} = Get.by_query("")

      assert {:ok,
              [
                %Offer{
                  description: ^description,
                  id: ^id,
                  image: ^image,
                  promotion_link: ^promotion_link,
                  user: ^user
                }
              ]} = {:ok, response}
    end
  end

  describe "by_id/1" do
    test "When id exist, return the offer" do
      %User{id: user_id} = insert(:user)
      %Offer{id: id} = insert(:offer, user_id: user_id)

      {:ok,
       %Offer{
         description: description,
         id: id,
         image: image,
         promotion_link: promotion_link,
         user: user
       } = response} = Get.by_id(id)

      assert {:ok,
              %Offer{
                description: ^description,
                id: ^id,
                image: ^image,
                promotion_link: ^promotion_link,
                user: ^user
              }} = {:ok, response}
    end
  end
end
