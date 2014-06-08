require 'test_helper'

class ExhibitControllerTest < ActionController::TestCase
  test "should get past" do
    get :past
    assert_response :success
  end

  test "should get current" do
    get :current
    assert_response :success
  end

  test "should get upcoming" do
    get :upcoming
    assert_response :success
  end

end
