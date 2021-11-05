defmodule OfferHunters.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :comment, :text

      add :user_id, references(:users, type: :binary_id)
      add :offer_id, references(:offers, type: :binary_id)

      timestamps()
    end
  end
end
