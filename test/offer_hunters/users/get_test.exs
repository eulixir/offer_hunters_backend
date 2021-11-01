defmodule OfferHunters.Users.GetTest do
  @moduledoc """
    Tests for get user module
  """
  use OfferHunters.DataCase, async: true

  import OfferHunters.Factory

  alias OfferHunters.{Error, User, Users.Get}

  describe "get_by_email/1" do
    test "When email exist, returns the user" do
      %User{id: id, email: email, name: name, profile_picture: profile_picture} = insert(:user)

      {:ok, response} =
        email
        |> Get.by_email()

      assert {:ok, %User{id: ^id, email: ^email, name: ^name, profile_picture: ^profile_picture}} =
               {:ok, response}
    end

    test "When the email not exist, returns an error" do
      response = Get.by_email("jp@banana.com")

      assert {:error,
              %Error{
                result: "Email does not exist",
                status: :not_found
              }} == response
    end
  end

  describe "all_users/0" do
    test "When called, returns a list of users" do
      %User{id: id} = insert(:user)

      response = Get.all_users()

      assert [
               %OfferHunters.User{
                 email: "jp@banana.com",
                 id: ^id,
                 name: "jp",
                 offers: [],
                 profile_picture: "src/banana"
               }
             ] = response
    end
  end
end
