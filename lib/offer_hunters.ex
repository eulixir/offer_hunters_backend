defmodule OfferHunters do
  @moduledoc """
  Fachade to turn application more fexible and more friendly to developer
  """

  alias OfferHunters.Users.Create, as: UsersCreate

  defdelegate create_user(params), to: UsersCreate, as: :call
end
