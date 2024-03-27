defmodule GoalmaticExAk556Web.ErrorJSONTest do
  use GoalmaticExAk556Web.ConnCase, async: true

  test "renders 404" do
    assert GoalmaticExAk556Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert GoalmaticExAk556Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
