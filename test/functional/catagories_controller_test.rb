require 'test_helper'

class CatagoriesControllerTest < ActionController::TestCase
  test "should get get_catagories" do
    get :get_catagories
    assert_response :success
  end

end
