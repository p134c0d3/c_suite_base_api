require './app/services/base_api/roles'

class User < ApplicationRecord
  has_secure_password
  # associations BEGIN
  has_many :user_roles
  has_many :roles, through: :user_roles
  # associations END
  
  # validations BEGIN
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP}
  # validations END

  include BaseApi::Roles

  # Methods BEGIN

  def name
    "#{first_name} #{last_name}"
  end

  # Methods END
  
end
