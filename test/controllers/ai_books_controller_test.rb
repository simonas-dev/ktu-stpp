require 'test_helper'

class AiBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ai_book = ai_books(:one)
  end

  test 'should get index' do
    get ai_books_url
    assert_response :success
  end

  test 'should get new' do
    get new_ai_book_url
    assert_response :success
  end

  test 'should create ai_book' do
    assert_difference('AiBook.count') do
      post ai_books_url, params: {
        ai_book: {
          name: @ai_book.name,
          page_count: @ai_book.page_count,
          summary: @ai_book.summary
        }
      }
    end
    assert_redirected_to ai_book_url(AiBook.last)
  end

  test 'should show ai_book' do
    get ai_book_url(@ai_book)
    assert_response :success
  end

  test 'should get edit' do
    get edit_ai_book_url(@ai_book)
    assert_response :success
  end

  test 'should update ai_book' do
    patch ai_book_url(@ai_book), params: {
      ai_book: {
        name: @ai_book.name,
        page_count: @ai_book.page_count,
        summary: @ai_book.summary
      }
    }
    assert_redirected_to ai_book_url(@ai_book)
  end

  test 'should destroy ai_book' do
    assert_difference('AiBook.count', -1) do
      delete ai_book_url(@ai_book)
    end
    assert_redirected_to ai_books_url
  end
end
