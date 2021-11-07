defmodule OfferHunters.Users.Create do
  @moduledoc """
    Inserts a user into the database.
  """

  alias OfferHunters.{Error, Repo, User}

  @doc """
  Recive the params and inserts the params into the database.

  ## Examples
  iex> OfferHunters.Users.Create.call(%{email: "jp@banana.com", name: "Jp", profile_picture: "src/banana"}).

      {:ok,
        %OfferHunters.User{
          __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
          id: "344c60eb-41fe-44a4-b2ca-95e336db0a0d",
          inserted_at: ~N[2021-09-09 13:52:59],
          updated_at: ~N[2021-09-09 13:52:59],
          email: "jp@banana.com",
          name: "Jp",
          profile_picture: "src/banana"
        }}

  iex> OfferHunters.Users.Create.call(%{email: "jp@banana.com"})
      {:error,
        %OfferHunters.Error{
          result: "The user is a already registered in database",
          status: :bad_request
      }}

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
        status: :bad_request
      }}
  """
  @spec call(%{email: String.t(), profile_picture: String.t(), name: String.t()}) ::
          {:ok, %User{}}
          | {:error, %OfferHunters.Error{result: String.t(), status: :bad_request}}

  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{id: id}}) do
    {:ok, Repo.preload(Repo.get(User, id), [:offers, :comments])}
  end

  defp handle_insert(
         {:error, %Ecto.Changeset{errors: [email: {"has already been taken", _reason}]}}
       ) do
    {:error, Error.build(:bad_request, "The user is a already registered in database")}
  end

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
