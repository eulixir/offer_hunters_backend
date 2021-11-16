defmodule OfferHunters.User do
  @moduledoc """
    Create Schema for User
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:email, :profile_picture, :name, :admin]
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id] ++ @required_params}

  schema "users" do
    field :email, :string
    field :name, :string
    field :profile_picture, :string
    field :admin, :boolean

    has_many :offers, OfferHunters.Offer
    has_many :comments, OfferHunters.Comment

    timestamps()
  end

  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(:email)
  end
end
