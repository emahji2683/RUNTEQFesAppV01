require "application_system_test_case"

class ContentListsTest < ApplicationSystemTestCase
  setup do
    @content_list = content_lists(:one)
  end

  test "visiting the index" do
    visit content_lists_url
    assert_selector "h1", text: "Content lists"
  end

  test "should create content list" do
    visit content_lists_url
    click_on "New content list"

    fill_in "Repeat content", with: @content_list.repeat_content
    fill_in "Repeat times", with: @content_list.repeat_times
    fill_in "Title", with: @content_list.title
    click_on "Create Content list"

    assert_text "Content list was successfully created"
    click_on "Back"
  end

  test "should update Content list" do
    visit content_list_url(@content_list)
    click_on "Edit this content list", match: :first

    fill_in "Repeat content", with: @content_list.repeat_content
    fill_in "Repeat times", with: @content_list.repeat_times
    fill_in "Title", with: @content_list.title
    click_on "Update Content list"

    assert_text "Content list was successfully updated"
    click_on "Back"
  end

  test "should destroy Content list" do
    visit content_list_url(@content_list)
    click_on "Destroy this content list", match: :first

    assert_text "Content list was successfully destroyed"
  end
end
