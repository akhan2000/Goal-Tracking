defmodule GoalmaticExAk556Web.ActivityController do
  use GoalmaticExAk556Web, :controller

  alias GoalmaticExAk556.Achievement
  alias GoalmaticExAk556.Achievement.Activity


  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end


  def index(conn, %{"challenge_id" => challenge_id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, challenge_id)
    activities = Achievement.list_challenge_activities(challenge)
    render(conn, :index, challenge: challenge, activities: activities)
  end


  def new(conn, %{"challenge_id" => challenge_id}, _current_user) do
    changeset = Achievement.change_activity(%Activity{})
    render(conn, :new, changeset: changeset, challenge_id: challenge_id)
  end

  def create(conn, %{"challenge_id" => challenge_id, "activity" => activity_params}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, challenge_id)
    case Achievement.create_activity(current_user, challenge, activity_params) do
      {:ok, activity} ->
        conn
        |> put_flash(:info, "Activity created successfully.")
        |> redirect(to: "/challenges/#{challenge_id}/activities/#{activity.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
         render(conn, :new, challenge: challenge, changeset: changeset)
    end
  end


  def show(conn, %{"challenge_id" => challenge_id, "id" => id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, challenge_id)
    activity = Achievement.get_challenge_activity!(challenge, id)
    render(conn, :show, activity: activity, challenge: challenge)
  end


  def edit(conn, %{"challenge_id" => challenge_id, "id" => id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, challenge_id)
    activity = Achievement.get_challenge_activity!(challenge, id)
    changeset = Achievement.change_activity(activity)
    render(conn, :edit, activity: activity, changeset: changeset, challenge: challenge)
  end


  def update(conn, %{"challenge_id" => challenge_id, "id" => id, "activity" => activity_params}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, challenge_id)
    activity = Achievement.get_challenge_activity!(challenge, id)

    case Achievement.update_activity(activity, activity_params) do
      {:ok, _activity} ->
        conn
        |> put_flash(:info, "Activity updated successfully.")
        |> redirect(to: "/challenges/#{challenge_id}/activities/#{activity.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, activity: activity, changeset: changeset, challenge_id: challenge_id)
    end
  end

  def delete(conn, %{"challenge_id" => challenge_id, "id" => id}, current_user) do
    challenge = Achievement.get_user_challenge!(current_user, challenge_id)
    activity = Achievement.get_challenge_activity!(challenge, id)
    {:ok, _activity} = Achievement.delete_activity(activity)
    conn
    |> put_flash(:info, "Activity deleted successfully.")
    |> redirect(to: "/challenges/#{challenge_id}/activities")
  end
end
