defmodule Judge.TaskJudgeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Judge.TaskJudge` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title",
        tl_millis: 42
      })
      |> Judge.TaskJudge.create_task()

    task
  end
end
