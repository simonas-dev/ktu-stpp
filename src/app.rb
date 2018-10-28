require 'sinatra'
require 'sinatra/json'
require 'active_model'
require 'mongo'
require 'mongo_mapper'
# require './src/models/book.rb'

set :environment, :production

configure do
  MongoMapper.setup({'production' => {'uri' => ENV['127.0.0.1:27017']}}, 'test')
end

# Create
post '/book' do
  body = Book.parseJson(request.body.read)
  book = {
    id: last_id,
    name: body['name'],
    summmary: body['summmary'],
    page_count: body['page_count']
  }
  json BOOK_DB.push(book)
end

# Update
put '/book/:id' do
  id = params['id'].to_i
  body = JSON.parse(request.body.read)
  book = BOOK_DB.find {|book| book[:id] == id }
  if book
    book[:name] = body['name']
    book[:summmary] = body['summmary']
    book[:page_count] = body['page_count']
    json book
  else
    status 404
    body "Which Book?"
  end
end

# Read
get '/book/:id' do
  id = params['id'].to_i
  book = BOOK_DB.find {|book| book[:id] == id }
  if book
    json book
  else
    status 404
    body "Which Book?"
  end
end

# Read
get '/book/:id/authors' do
  id = params['id'].to_i
  book = BOOK_DB.find {|book| book[:id] == id }
  if book
    json book[:author_list]
  else
    status 404
    body "Which Book?"
  end
end

# Read List
get '/book' do
  json Book.all
end

# Delete
delete '/book/:id' do
  id = params['id'].to_i
  book = BOOK_DB.find {|book| book[:id] == id } 
  if book
    json BOOK_DB.delete(book)
  else
    status 404
    body "Which Book?"
  end
end

class Book
  include MongoMapper::Document
  
  key :id, String
  key :name, String
  key :summmary, String
  key :page_count, Integer
  
  # many :authors
end

error Sinatra::NotFound do
  content_type 'text/plain'
  [400, 'Bad Request']
end
