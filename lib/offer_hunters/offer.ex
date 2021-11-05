defmodule OfferHunters.Offer do
  @moduledoc """
    Create Schema for Offer
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias OfferHunters.User

  @required_params [
    :description,
    :promotion_link,
    :image,
    :expiration_date,
    :value,
    :user_id
  ]
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id] ++ @required_params ++ [:user]}

  schema "offers" do
    field :description, :string
    field :promotion_link, :string
    field :image, :string
    field :expiration_date, :string
    field :value, :decimal

    belongs_to :user, User, type: :binary_id

    timestamps()
  end

  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(:promotion_link)
    |> cast_assoc(:user)
  end
end
