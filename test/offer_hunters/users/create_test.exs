defmodule OfferHunters.Users.CreateTest do
  @moduledoc """
    Tests for create user module
  """
  use OfferHunters.DataCase, async: true

  import OfferHunters.Factory

  alias OfferHunters.{Error, User, Users.Create}

  describe "call/1" do
    test "When all params are valid, creates the user" do
      {:ok, response} =
        :user_params
        |> build()
        |> Create.call()

      %User{id: id, email: email, name: name, profile_picture: profile_picture} = response

      assert {:ok, %User{id: ^id, email: ^email, name: ^name, profile_picture: ^profile_picture}} =
               {:ok, response}
    end

    test "When there the email already registered, returns an error" do
      insert(:user)

      response =
        :user_params
        |> build()
        |> Create.call()

      assert {:error,
              %Error{
                result: "The user is a already registered in database",
                status: :bad_request
              }} == response
    end
  end
end
