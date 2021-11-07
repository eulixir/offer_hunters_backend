defmodule OfferHunters.Comments.Get do
  @moduledoc """
    Module for get comments
  """
  alias OfferHunters.{Comment, Error, Repo}

  def by_id(id) do
    case Repo.get(Comment, id) do
      %Comment{} = comment ->
        {:ok, comment}

      nil ->
        {:error, Error.build(:not_found, "This id does't exist")}
    end
  end
end
