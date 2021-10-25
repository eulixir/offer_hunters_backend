defmodule OfferHunters.Users.Get do
  alias OfferHunters.{Repo, User}

  def get_email(email) do
    case Repo.get_by(User, email: email) do
      %User{} = user -> {:ok, user}
      nil -> {:error, "Email does not exist"}
    end
  end
end
