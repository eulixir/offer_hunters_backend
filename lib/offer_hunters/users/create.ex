defmodule OfferHunters.Users.Create do
  @moduledoc """
    Inserts a user into the database.
  """

  alias OfferHunters.{Error, Repo, User}

  def call(%{} = params) do
    user = User.changeset(params)

    case Repo.insert(user) do
      {:ok, user} ->
        {:ok, user}

      {:error, %Ecto.Changeset{errors: [email: {"has already been taken", _reason}]}} ->
        {:error, Error.build(:bad_request, "The user is a already registered in database")}

      {:error, result} ->
        {:error, Error.build(:bad_request, result)}
    end
  end

  def call(_anything), do: {:error, Error.build(:bad_request, "Insert the user in a map format")}
end
