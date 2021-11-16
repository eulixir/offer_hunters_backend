defmodule OfferHuntersWeb.Router do
  use OfferHuntersWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", OfferHuntersWeb do
    pipe_through :api

    get "/home", HomeController, :index
  end

  scope "/user", OfferHuntersWeb do
    pipe_through :api

    post "/create", UserController, :create

    get "/get_all", UserController, :get_all

    get "/get_by_email", UserController, :get_by_email

    put "/set_admin", UserController, :set_admin
  end

  scope "/offer", OfferHuntersWeb do
    pipe_through :api

    post "/create", OfferController, :create

    get "/get_by_id", OfferController, :get_by_id

    get "/get_by_query", OfferController, :get_by_query

    delete "/delete", OfferController, :delete_by_id

    put "/verify_offer", OfferController, :verify_offer
  end

  scope "/comment", OfferHuntersWeb do
    pipe_through :api

    post "create", CommentController, :create

    delete "delete", CommentController, :delete
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: OfferHuntersWeb.Telemetry
    end
  end
end
