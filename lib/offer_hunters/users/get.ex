defmodule OfferHunters.Users.Get do
  @moduledoc """
    Get Users data
  """
  alias OfferHunters.{Error, Repo, User}

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build(:bad_request, "Email does not exist")}
    end
  end

  def get_all_users, do: Repo.all(User)
end
