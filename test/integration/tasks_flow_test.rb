require "test_helper"

class TasksFlowTest < ActionDispatch::IntegrationTest
  setup do
    post login_path, params: { email: users(:afu).email, password: "password123" }
  end

  test "user can create sort and complete tasks" do
    get tasks_path(sort: "due_date")
    assert_response :success
    assert_select "body", /Due today/
    assert_select "body", /Pay supplier invoice/

    assert_difference "Task.count", 1 do
      post tasks_path, params: {
        task: {
          description: "Call Turboly recruiter",
          due_date: Date.current,
          priority: 2
        }
      }
    end
    assert_redirected_to tasks_path

    task = Task.order(:created_at).last
    patch complete_task_path(task)
    assert_redirected_to tasks_path
    assert task.reload.completed?
  end

  test "user cannot see another user's tasks" do
    other = User.create!(email: "other@example.com", password: "password123", password_confirmation: "password123")
    hidden = other.tasks.create!(description: "Hidden task", due_date: Date.current, priority: 1)

    get task_path(hidden)
    assert_response :not_found
  end
end
