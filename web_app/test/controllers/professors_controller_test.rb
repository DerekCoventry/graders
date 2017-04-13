require 'test_helper'

class ProfessorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get professors_index_url
    assert_response :success
  end

  test "should get recommendations" do
    get professors_recommendations_url
    assert_response :success
  end

end
