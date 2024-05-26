class Event < ApplicationRecord
  # Associations BEGIN
  belongs_to :organization
  has_many :team_events
  has_many :teams, through: :team_events
  has_many :event_team_users
  has_many :users, through: :event_team_users

  validates :title, :location, :date, presence: true
end
