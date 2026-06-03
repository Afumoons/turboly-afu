require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "requires description, due date, and priority" do
    task = Task.new(user: users(:afu), priority: nil)

    assert_not task.valid?
    assert_includes task.errors[:description], "can't be blank"
    assert_includes task.errors[:due_date], "can't be blank"
    assert_includes task.errors[:priority], "is not included in the list"
  end

  test "marks completion timestamp when completed" do
    task = tasks(:later)

    assert_changes -> { task.completed_at }, from: nil do
      task.update!(completed: true)
    end
  end

  test "finds tasks due today" do
    due_today = Task.due_today

    assert_includes due_today, tasks(:today)
    assert_not_includes due_today, tasks(:later)
  end
end
