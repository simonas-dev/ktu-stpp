require 'sinatra'
require 'sinatra/json'

set :environment, :production

# Author
THE_AUTHOR = {
  first_name: "Simonas",
  last_name: "Sankauskas",
  group: "IFF-5/3"
}

SAMPLE_AUTHOR = {
  first_name: "Fist Name",
  last_name: "Last Name",
  group: "Any Group"
}


# Books
OG_BOOK = { 
  id: 1,
  name: "The Orignal Book",
  summmary: "Super Cool Book About Things and Stuff.",
  page_count: 3,
  author_list: [THE_AUTHOR]
}

SAMPLE_BOOK = {
  id: 2,
  name: "Lorem ipsum",
  summmary: "Et dolor sunt perferendis in et ut et. Perspiciatis ipsum id consectetur
  iure voluptatum rer…",
  page_count: 999999,
  author_list: [SAMPLE_AUTHOR]
}

BRAVE_NEW_WORLD = {
  id: 3,
  name: "Brave New World",
  summmary: "Dude from the old world gets a bit of a culture shock.",
  page_count: 311,
  author_list: [SAMPLE_AUTHOR]
}

UNIX_HATERS_HANDBOOK = {
  id: 4,
  name: "The UNIXHATERS Handbook",
  summmary: "Two of the most famous products of Berkeley are LSD and Unix.
  I don’t think that is a coincidence.",
  page_count: 360,
  author_list: [SAMPLE_AUTHOR]
}

BOOK_DB = [
  OG_BOOK,
  SAMPLE_BOOK,
  BRAVE_NEW_WORLD,
  UNIX_HATERS_HANDBOOK
]

last_id = 4

# Create
post '/book' do
  last_id += 1
  body = JSON.parse(request.body.read)
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
  json BOOK_DB
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

error Sinatra::NotFound do
  content_type 'text/plain'
  [400, 'Bad Request']
end
