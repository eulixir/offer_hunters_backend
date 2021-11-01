defmodule OfferHunters.Factory do
  @moduledoc """
    false
  """
  use ExMachina.Ecto, repo: OfferHunters.Repo

  alias OfferHunters.User

  def user_params_factory do
    %{
      "email" => "jp@banana.com",
      "name" => "Jp",
      "profile_picture" => "src/banana"
    }
  end

  def user_factory do
    %User{
      email: "jp@banana.com",
      name: "jp",
      profile_picture: "src/banana"
    }
  end
end
