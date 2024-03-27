defmodule GoalmaticExAk556Web.ChallengeHTML do
  use GoalmaticExAk556Web, :html

  embed_templates "challenge_html/*"
  def search_box(assigns) do
    ~H"""
      <form class="flex items-center">
        <label class="relative flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search absolute left-2" viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
          </svg>
          <input type="text" name="search" value={assigns[:q] || ""} placeholder="Search..." class="pl-7 border border-gray-300 rounded">
        </label>
        <button type="submit" class="ml-2 px-2 py-1 bg-gray-700 text-white rounded">Go</button>
      </form>
    """
  end


  @doc """
  Renders a challenge form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def challenge_form(assigns)
end
