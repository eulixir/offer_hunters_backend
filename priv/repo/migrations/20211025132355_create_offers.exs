defmodule OfferHunters.Repo.Migrations.CreateOffers do
  use Ecto.Migration

  def change do
    create table(:offers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :string
      add :promotion_link, :string
      add :image, :string
      add :expiration_date, :string
      add :value, :decimal

      add :user_id, references(:users, type: :binary_id)

      timestamps()
    end

    create unique_index(:offers, :promotion_link)
  end
end
