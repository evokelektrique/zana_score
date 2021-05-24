defmodule ZanaScore.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
  	create table(:users) do
  		add :first_name, :string
  		add :last_name, :string
  		add :email, :string, null: false
  		add :score, :integer, default: 0
  		add :ref_id, :string
  	end

  	create unique_index(:users, [:email])
  end

  def down do
  	drop table(:users)
  end
end
