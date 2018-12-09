Author.delete_all
Book.delete_all

THE_AUTHOR = Author.create!(
  first_name: 'Simonas',
  last_name: 'Sankauskas',
  group: 'IFF-5/3'
)

SAMPLE_AUTHOR = Author.create!(
  first_name: 'Fist Name',
  last_name: 'Last Name',
  group: 'Any Group'
)

# Books
OG_BOOK = {
  name: 'The Orignal Book',
  summmary: 'Super Cool Book About Things and Stuff.',
  page_count: 3,
  authors: [THE_AUTHOR]
}.freeze

SAMPLE_BOOK = {
  name: 'Lorem ipsum',
  summmary: "Et dolor sunt perferendis in et ut et. Perspiciatis ipsum id consectetur
  iure voluptatum rer…",
  page_count: 999_999,
  authors: [SAMPLE_AUTHOR]
}.freeze

BRAVE_NEW_WORLD = {
  name: 'Brave New World',
  summmary: 'Dude from the old world gets a bit of a culture shock.',
  page_count: 311,
  authors: [SAMPLE_AUTHOR]
}.freeze

UNIX_HATERS_HANDBOOK = {
  name: 'The UNIXHATERS Handbook',
  summmary: "Two of the most famous products of Berkeley are LSD and Unix.
  I don’t think that is a coincidence.",
  page_count: 360,
  authors: [SAMPLE_AUTHOR]
}.freeze

Book.create!(
  name: 'The UNIXHATERS Handbook',
  summmary: "Two of the most famous products of Berkeley are LSD and Unix.
  I don’t think that is a coincidence.",
  page_count: 360,
  authors: [SAMPLE_AUTHOR]
)

BOOK_DB = [
  OG_BOOK,
  SAMPLE_BOOK,
  BRAVE_NEW_WORLD,
  UNIX_HATERS_HANDBOOK
].freeze

BOOK_DB.each { |book| Book.create!(book) }
