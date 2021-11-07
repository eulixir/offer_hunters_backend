defmodule OfferHunters.Comments.Delete do
  @moduledoc """
    Module for delete comments
  """
  alias OfferHunters.{Comment, Repo}

  def call(id) do
    case OfferHunters.get_comment_by_id(id) do
      {:ok, %Comment{} = comment} ->
        Repo.delete(comment)

      {:error, reason} ->
        {:error, reason}
    end
  end
end
