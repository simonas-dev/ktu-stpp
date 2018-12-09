# Create initial Book and Author table
class CreateBook < ActiveRecord::Migration[5.1]

  def change
    create_books
    create_authors
  end

  def create_books
    create_table :books do |t|
      t.string :name
      t.text :summmary
      t.integer :page_count
      t.timestamps
    end
  end

  def create_authors
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :group
      t.timestamps
    end
  end
end
