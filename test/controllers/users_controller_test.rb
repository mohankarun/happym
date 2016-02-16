require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get change_password" do
    get :change_password
    assert_response :success
  end

end
