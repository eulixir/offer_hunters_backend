defmodule OfferHunters.UserTest do
  @moduledoc """
    Tests for user Schema
  """
  use OfferHunters.DataCase, async: true

  import OfferHunters.Factory

  alias Ecto.Changeset

  alias OfferHunters.User

  describe "changeset/1" do
    test "When all params are valid, returns a valid changeset" do
      response =
        :user_params
        |> build()
        |> User.changeset()

      assert %Changeset{
               changes: %{
                 email: "jp@banana.com"
               },
               valid?: true
             } = response
    end
  end

  test "When the email field is empty, returns an error" do
    response = User.changeset(%{})

    assert %Changeset{
             changes: %{},
             errors: [
               email: {"can't be blank", [validation: :required]},
               profile_picture: {"can't be blank", [validation: :required]},
               name: {"can't be blank", [validation: :required]}
             ],
             valid?: false
           } = response
  end
end
