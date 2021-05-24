defmodule ZanaScoreWeb.UserController do
  use ZanaScoreWeb, :controller

  require Logger

  alias ZanaScore.{User, Repo}

  # action_fallback ZanaScoreWeb.FallbackController

  plug :find_user when not (action in [:create, :referal])

  def referal(conn, _) do
    %{"ref_id" => ref_id} = conn.params

    case Repo.get_by(User, ref_id: ref_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ZanaScoreWeb.UserView)
        |> render("error.json", reason: :user_not_found)

      user ->
        conn
        |> put_status(:ok)
        |> render("show.json", %{user: user})
    end
  end

  def show(conn, _) do
    user = conn.assigns.user

    conn
    |> put_status(:ok)
    |> render("show.json", %{user: user})
  end

  def create(conn, %{"user" => user_params}) do
    changeset = %User{} |> User.changeset(user_params)
    ref_id = :erlang.phash2(user_params["email"], 999_999) |> Integer.to_string()
    changeset = changeset |> Ecto.Changeset.put_change(:ref_id, ref_id)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("create.json", %{user: user})

      # Error In Changeset
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ZanaScoreWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  def score(conn, _) do
  end

  def set_score(conn, %{"user" => user_params}) do
    user = conn.assigns.user
    changeset = user |> User.changeset()
    new_score = user.score + user_params["score"]
    changeset = changeset |> Ecto.Changeset.put_change(:score, new_score)

    case Repo.update(changeset, returning: true) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("show.json", %{user: user})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(ZanaScoreWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  # Find and assign user to conn
  defp find_user(conn, _) do
    %{"email" => email} = conn.params

    case Repo.get_by(User, email: email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ZanaScoreWeb.UserView)
        |> render("error.json", reason: :user_not_found)

      user ->
        conn
        |> assign(:user, user)
    end
  end
end
