require "application_system_test_case"

class AiBooksTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit ai_books_url
  
    assert_selector "h1", text: "AiBook"
  end
end
