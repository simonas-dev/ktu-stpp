class Author < ApplicationRecord
  has_and_belongs_to_many :books, autosave: true
  accepts_nested_attributes_for :books
  def as_json(options={})
    super(:include => { :books => { :except => []}})
  end
end
