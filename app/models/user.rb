require './app/services/base_api/roles'

class User < ApplicationRecord
  # associations BEGIN
  has_secure_password
  belongs_to :organization
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :event_team_users
  has_many :events, through: :event_team_users
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
