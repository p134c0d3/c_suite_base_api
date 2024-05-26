# app/models/event_team_user.rb
class EventTeamUser < ApplicationRecord
    belongs_to :event
    belongs_to :team
    belongs_to :user
  
    validates :user_id, uniqueness: { scope: [:event_id, :team_id] }
  end
  