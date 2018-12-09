# Scaffold migration for generating AiBooks.
class CreateAiBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :ai_books do |t|
      t.string :name
      t.string :summary
      t.integer :page_count

      t.timestamps
    end
  end
end
