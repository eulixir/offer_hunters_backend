defmodule OfferHunters.Factory do
  @moduledoc """
    false
  """
  use ExMachina.Ecto, repo: OfferHunters.Repo

  alias OfferHunters.{Offer, User}

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

  def offer_params_factory do
    %{
      "expiration_date" => "2019-15-10",
      "description" => "Placa de vídeo Galax GeForce RTX 3080 HOF",
      "image" => "src/banana",
      "promotion_link" =>
        "https =>//www.terabyteshop.com.br/produto/19609/placa-de-video-galax-geforce-rtx-3080-hof-lhr-10gb-gddr6x-dlss-ray-tracing-38nwm3md3bjj?p=714486#banana",
      "value" => 10999.0,
      "user_id" => "a66d859c-b3e4-4482-8460-615d97f91eab"
    }
  end
end
