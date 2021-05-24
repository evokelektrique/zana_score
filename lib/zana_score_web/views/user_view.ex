defmodule ZanaScoreWeb.UserView do
  use ZanaScoreWeb, :view
  alias __MODULE__

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      score: user.score,
      ref_id: user.ref_id
    }
  end

  def render("create.json", %{user: user}) do
    %{
      status: :ok,
      message: gettext("User created successfully."),
      data: render_one(user, UserView, "user.json")
    }
  end

  def render("error.json", %{reason: reason}) do
    case reason do
      :user_not_found ->
        %{status: reason, message: gettext("User not found")}
    end
  end
end
