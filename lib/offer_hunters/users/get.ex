defmodule OfferHunters.Users.Get do
  @moduledoc """
    Get Users data
  """
  alias OfferHunters.{Error, Repo, User}

  @doc """
  Recive the email and seacrh this into the database.

  ## Examples
  iex> OfferHunters.Users.Get.by_email("jp@banana.com")
        {:ok,
          %OfferHunters.User{
            __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
            email: "jp@banana.com",
            id: "a66d859c-b3e4-4482-8460-615d97f91eab",
            inserted_at: ~N[2021-10-26 13:39:48],
            name: "Jp",
            offers: #Ecto.Association.NotLoaded<association :offers is not loaded>,
            profile_picture: "src/banana",
            updated_at: ~N[2021-10-26 13:39:48]
        }}

  iex> OfferHunters.Users.Create.call(%{email: "jp@banana.com"})
        {:error, %OfferHunters.Error{result: "Email does not sexist", status: :bad_request}}

  iex> OfferHunters.Users.Create.call(%{})
      {:error,
        %OfferHunters.Error{
          result: #Ecto.Changeset<
          action: :insert,
          changes: %{},
          errors: [
            email: {"can't be blank", [validation: :required]},
            profile_picture: {"can't be blank", [validation: :required]},
            name: {"can't be blank", [validation: :required]}
          ],
          data: #OfferHunters.User<>,
          valid?: false
        >,
        status: :not_found
      }}
  """
  @spec by_email(String.t()) ::
          {:ok, %User{}}
          | {:error, %OfferHunters.Error{result: String.t(), status: :not_found}}

  def by_email(email) do
    case Repo.preload(Repo.get_by(User, email: email), [:offers, :comments]) do
      %User{id: id} -> {:ok, Repo.preload(Repo.get(User, id), [:offers, :comments])}
      nil -> {:error, Error.build(:not_found, "Email does not exist")}
    end
  end

  @doc """
  When called, return a list of all users

  ## Examples
  iex> OfferHunters.Users.Get.all_users()
  """
  @spec all_users() ::
          [
            %OfferHunters.User{
              email: String.t(),
              id: String.t(),
              name: String.t(),
              profile_picture: String.t(),
              offers: %{
                description: String.t(),
                promotion_link: String.t(),
                image: bitstring(),
                expiration_date: Date.t(),
                value: Decimal.t()
              }
            }
          ]

  def all_users, do: Repo.preload(Repo.all(User), [:offers, :comments])

  def by_id(id) do
    banana =
      case Repo.preload(Repo.get(User, id), [:offers, :comments]) do
        %User{id: id} -> {:ok, Repo.preload(Repo.get(User, id), [:offers, :comments])}
        nil -> {:error, Error.build(:not_found, "Email does not exist")}
      end

    banana
  end
end
