defmodule OfferHunters.Users.Update do
  alias OfferHunters.{Error, User, Repo}

  def set_admin(email) do
    case OfferHunters.get_user_by_email(email) do
      {:ok, %{id: id}} ->
        User
        |> Repo.get(id)
        |> User.changeset(%{admin: true})
        |> Repo.update()

      {:error, reason} ->
        {:error, reason}
    end
  end
end
