defmodule Judge.TaskJudgeTest do
  use Judge.DataCase

  alias Judge.TaskJudge

  describe "tasks" do
    alias Judge.TaskJudge.Task

    import Judge.TaskJudgeFixtures

    @invalid_attrs %{description: nil, title: nil, tl_millis: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskJudge.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskJudge.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{description: "some description", title: "some title", tl_millis: 42}

      assert {:ok, %Task{} = task} = TaskJudge.create_task(valid_attrs)
      assert task.description == "some description"
      assert task.title == "some title"
      assert task.tl_millis == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskJudge.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", tl_millis: 43}

      assert {:ok, %Task{} = task} = TaskJudge.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.title == "some updated title"
      assert task.tl_millis == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskJudge.update_task(task, @invalid_attrs)
      assert task == TaskJudge.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskJudge.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskJudge.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskJudge.change_task(task)
    end
  end
end
