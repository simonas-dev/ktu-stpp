class Author
  include MongoMapper::EmbeddedDocument

  key :first_name, String
  key :last_name, String
  key :group, String
end