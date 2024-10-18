require 'test_helper'

class Admin::LoansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_loans_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_loans_update_url
    assert_response :success
  end

end
