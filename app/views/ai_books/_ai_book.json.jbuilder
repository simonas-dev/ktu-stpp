json.extract! ai_book, :id, :name, :summary, :page_count, :created_at, :updated_at
json.url ai_book_url(ai_book, format: :json)
