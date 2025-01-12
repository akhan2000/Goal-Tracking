defmodule GoalmaticExAk556Web.ChallengeController do
  use GoalmaticExAk556Web, :controller

  alias GoalmaticExAk556.Achievement
  alias GoalmaticExAk556.Achievement.Challenge

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
end

def index(conn, params, current_user) do
  search_term = Map.get(params, "search", "")
  challenges = Achievement.list_user_challenges(current_user, search_term)
  render(conn, :index, challenges: challenges)
end



  def new(conn, _params, _current_user) do
    changeset = Achievement.change_challenge(%Challenge{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"challenge" => challenge_params}, current_user) do
    case Achievement.create_challenge(current_user, challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge created successfully.")
        |> redirect(to: ~p"/challenges/#{challenge}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, id)
    activities = Achievement.list_challenge_activities(challenge)
    total_progress=Achievement.total_progress(challenge)
    render(conn, :show, challenge: challenge, activities: activities, total_progress: total_progress)
  end

  def edit(conn, %{"id" => id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, id)
    changeset = Achievement.change_challenge(challenge)
    render(conn, :edit, challenge: challenge, changeset: changeset)
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, id)

    case Achievement.update_challenge(challenge, challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge updated successfully.")
        |> redirect(to: ~p"/challenges/#{challenge}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, challenge: challenge, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, id)
    {:ok, _challenge} = Achievement.delete_challenge(challenge)

    conn
    |> put_flash(:info, "Challenge deleted successfully.")
    |> redirect(to: ~p"/challenges")
  end
end
