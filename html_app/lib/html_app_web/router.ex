defmodule HtmlAppWeb.Router do
  use HtmlAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HtmlAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/hangman", HtmlAppWeb do
    pipe_through :browser

    get "/", HangmanController, :index
    post "/", HangmanController, :new
    put "/", HangmanController, :update

    # used for Post->Redirect->Get so we avoid duplicate POSTs on browser refresh
    get "/current", HangmanController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", HtmlAppWeb do
  #   pipe_through :api
  # end
end
