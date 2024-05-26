class Team < ApplicationRecord
    belongs_to :organization
    has_many :user_teams
    has_many :users, through: :user_teams
    has_many :team_events
    has_many :events, through: :team_events

    validates :name, presence: true

    def members
        users
    end
end