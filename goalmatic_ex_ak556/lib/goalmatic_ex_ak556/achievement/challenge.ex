defmodule GoalmaticExAk556.Achievement.Challenge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challenges" do
    field :description, :string
    field :ends_at, :date
    field :goal, :integer
    field :name, :string
    field :units, :string
    belongs_to :user, GoalmaticExAk556.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name, :description, :units, :goal, :ends_at])
    |> validate_required([:name, :goal, :ends_at])
  end
end
