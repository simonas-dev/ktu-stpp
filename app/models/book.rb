class Book < ApplicationRecord
  has_and_belongs_to_many :authors, autosave: true
  accepts_nested_attributes_for :authors

  validates :name, :summmary, presence: true
  validates :name, length: { maximum: 256 }
  validates :summmary, length: { maximum: 1000 }
  validates :page_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def as_json(_options = {})
    super(include: { authors: { except: [] } })
  end
end
