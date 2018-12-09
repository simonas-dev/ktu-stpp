class Admin < ApplicationRecord
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  class << self
    def authenticate(email, password)
      user = Admin.find_for_authentication(email: email)
      user.try(:valid_password?, password) ? user : nil
    end
  end
end
