require 'test_helper'

class AuthControllerTest < ActionController::TestCase
  test "should get constantcontact" do
    get :constantcontact
    assert_response :success
  end

end
