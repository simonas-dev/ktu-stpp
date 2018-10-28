class Book
  include MongoMapper::Document
  
  key :id, String
  key :name, String
  key :summmary, String
  key :page_count, Integer
  
  # many :authors
end