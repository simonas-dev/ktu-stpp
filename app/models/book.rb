class Book < ApplicationRecord
  has_and_belongs_to_many :authors, autosave: true
  accepts_nested_attributes_for :authors

  def as_json(options={})
    super(:include => { :authors => { :except => []}})
  end
end
