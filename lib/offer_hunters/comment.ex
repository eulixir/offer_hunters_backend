defmodule OfferHunters.Comment do
  @moduledoc """
    Create Schema for comment
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias OfferHunters.{Offer, User}

  @required_params [
    :comment,
    :offer_id,
    :user_id
  ]
  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id] ++ @required_params ++ [:user, :offer]}

  schema "comments" do
    field :comment, :string

    belongs_to :user, User, type: :binary_id
    belongs_to :offer, Offer, type: :binary_id

    timestamps()
  end

  def changeset(%{} = attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> cast_assoc(:user)
    |> cast_assoc(:offer)
  end
end
