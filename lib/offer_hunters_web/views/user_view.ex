defmodule OfferHuntersWeb.UserView do
  use OfferHuntersWeb, :view

  def render("created.json", %{user: user}), do: %{user: user}

  def render("get_all.json", %{users: users}), do: %{users: users}

  def render("user.json", %{user: user}) do
    IO.inspect(user)

    %{
      user: %{
        name: user.name,
        id: user.id,
        profile_picture: user.profile_picture,
        offers: user.offers,
        comments: user.comments
      }
    }
  end

  def render("deleted.json", %{email: email}),
    do: %{message: "The user #{email} has been deleted"}
end
