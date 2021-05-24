defmodule ZanaScoreWeb.Router do
  use ZanaScoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ZanaScoreWeb do
    pipe_through :api

    scope "/users" do
      post "/", UserController, :create
      get "/referal/:ref_id", UserController, :referal

      scope "/:email" do
        get "/", UserController, :show
        get "/score", UserController, :score
        post "/score", UserController, :set_score
      end
    end
  end
end
