defmodule OfferHunters.Users.Create do
  alias OfferHunters.{User, Repo}

  def call(%{name: _name, email: _email, profile_picture: _profile_picture} = params) do
    user = User.changeset(params)

    case Repo.insert(user) do
      {:ok, user} -> {:ok, user}
      {:error, error} -> {:error, error}
    end
  end
end
