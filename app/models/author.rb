class Author < ApplicationRecord
  has_and_belongs_to_many :books, autosave: true
  accepts_nested_attributes_for :books
  
  validates :first_name, :last_name, :presence => true
  validates_format_of :group, with: /([A-Z]+)-(\d+)\/(\d+)/i
  
  def as_json(options={})
    super(:include => { :books => { :except => []}})
  end
end
