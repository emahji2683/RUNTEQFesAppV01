require "test_helper"

class ContentListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @content_list = content_lists(:one)
  end

  test "should get index" do
    get content_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_content_list_url
    assert_response :success
  end

  test "should create content_list" do
    assert_difference("ContentList.count") do
      post content_lists_url, params: { content_list: { repeat_content: @content_list.repeat_content, repeat_times: @content_list.repeat_times, title: @content_list.title } }
    end

    assert_redirected_to content_list_url(ContentList.last)
  end

  test "should show content_list" do
    get content_list_url(@content_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_content_list_url(@content_list)
    assert_response :success
  end

  test "should update content_list" do
    patch content_list_url(@content_list), params: { content_list: { repeat_content: @content_list.repeat_content, repeat_times: @content_list.repeat_times, title: @content_list.title } }
    assert_redirected_to content_list_url(@content_list)
  end

  test "should destroy content_list" do
    assert_difference("ContentList.count", -1) do
      delete content_list_url(@content_list)
    end

    assert_redirected_to content_lists_url
  end
end
