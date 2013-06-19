require 'test_helper'

class TodoListsControllerTest < ActionController::TestCase
  test "should get create_todo" do
    get :create_todo
    assert_response :success
  end

end
