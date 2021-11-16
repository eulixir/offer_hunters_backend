defmodule OfferHuntersWeb.UserController do
  use OfferHuntersWeb, :controller

  alias OfferHunters.{User, Users.Update}

  action_fallback OfferHuntersWeb.FallbackController

  def create(conn, %{"email" => email, "name" => name, "profile_picture" => profile_picture}) do
    with {:ok, %User{} = user} <-
           OfferHunters.create_user(%{
             "email" => email,
             "name" => name,
             "profile_picture" => profile_picture
           }) do
      conn
      |> put_status(:created)
      |> render("created.json", user: user)
    end
  end

  def get_all(conn, _params) do
    users = OfferHunters.get_all_users()

    conn
    |> put_status(:ok)
    |> render("get_all.json", users: users)
  end

  def set_admin(conn, %{"email" => email}) do
    with {:ok, message} <- Update.set_admin(email) do
      conn
      |> put_status(:ok)
      |> render("user_message.json", message: message)
    end
  end

  def get_by_email(conn, %{"email" => email}) do
    with {:ok, user} <-
           OfferHunters.get_user_by_email(email) do
      conn
      |> put_status(:ok)
      |> render("user_message.json", user: user)
    end
  end
end
