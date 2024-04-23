require "test_helper"

class AffiliationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @affiliation = affiliations(:one)
  end

  test "should get index" do
    get affiliations_url, as: :json
    assert_response :success
  end

  test "should create affiliation" do
    assert_difference("Affiliation.count") do
      post affiliations_url, params: { affiliation: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show affiliation" do
    get affiliation_url(@affiliation), as: :json
    assert_response :success
  end

  test "should update affiliation" do
    patch affiliation_url(@affiliation), params: { affiliation: {  } }, as: :json
    assert_response :success
  end

  test "should destroy affiliation" do
    assert_difference("Affiliation.count", -1) do
      delete affiliation_url(@affiliation), as: :json
    end

    assert_response :no_content
  end
end
