require 'test_helper'

class LukisansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lukisan = lukisans(:one)
  end

  test "should get index" do
    get lukisans_url, as: :json
    assert_response :success
  end

  test "should create lukisan" do
    assert_difference('Lukisan.count') do
      post lukisans_url, params: { lukisan: { description: @lukisan.description, imagepath: @lukisan.imagepath, title: @lukisan.title } }, as: :json
    end

    assert_response 201
  end

  test "should show lukisan" do
    get lukisan_url(@lukisan), as: :json
    assert_response :success
  end

  test "should update lukisan" do
    patch lukisan_url(@lukisan), params: { lukisan: { description: @lukisan.description, imagepath: @lukisan.imagepath, title: @lukisan.title } }, as: :json
    assert_response 200
  end

  test "should destroy lukisan" do
    assert_difference('Lukisan.count', -1) do
      delete lukisan_url(@lukisan), as: :json
    end

    assert_response 204
  end
end
