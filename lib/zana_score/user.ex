defmodule ZanaScore.User do
  use Ecto.Schema

  import Ecto.Changeset

  @required_params [:first_name, :last_name, :email]

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :score, :integer, default: 0
    field :ref_id, :string
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(:email)
  end
end
