defmodule GoalmaticExAk556.Achievement.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :amount, :integer
    field :note, :string
    belongs_to :challenge, GoalmaticExAk556.Achievement.Challenge
    belongs_to :user, GoalmaticExAk556.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:note, :amount])
    |> validate_required([:amount])
  end
end
