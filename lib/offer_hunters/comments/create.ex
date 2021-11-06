defmodule OfferHunters.Comments.Create do
  @moduledoc """
    Module for create comments
  """
  alias OfferHunters.{Comment, Error, Offer, User, Repo}

  def call(%{} = params) do
    case validate_ids(params) do
      {:ok, _message} ->
        params
        |> Comment.changeset()
        |> Repo.insert()
        |> handle_insert()

      _ ->
        {:error, Error.build(:bad_request, "Invalid Ids")}
    end
  end

  defp handle_insert({:ok, %Comment{id: id}}),
    do: {:ok, Repo.preload(Repo.get(Comment, id), [:user, :offer])}

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}

  defp validate_ids(%{
         "comment" => _comment,
         "offer_id" => offer_id,
         "user_id" => user_id
       }) do
    with {:ok, %Offer{}} <- OfferHunters.get_offer_by_id(offer_id),
         {:ok, %User{}} <- OfferHunters.get_user_by_id(user_id),
         do: {:ok, "Id's verified"}
  end
end

# map = %{
#   comment: "sla mano, banana pra vcs",
#   offer_id: "1e5313c8-374a-4d1f-b539-d859eb219e43",
#   user_id: "4c0147c4-4dd6-4217-ba1c-1b6ff65b173d"
# }
