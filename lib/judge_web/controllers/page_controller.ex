defmodule JudgeWeb.PageController do
  use JudgeWeb, :controller

  def home(conn, _params) do
    redirect(conn, to: ~p"/tasks")
  end
end
