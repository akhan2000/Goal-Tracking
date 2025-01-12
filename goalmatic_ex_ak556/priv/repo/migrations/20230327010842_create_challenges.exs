defmodule GoalmaticExAk556.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :name, :string
      add :description, :string
      add :units, :string
      add :goal, :integer
      add :ends_at, :utc_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:challenges, [:user_id])
  end
end
