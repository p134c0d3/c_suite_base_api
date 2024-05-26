# app/models/team_event.rb
class TeamEvent < ApplicationRecord
    belongs_to :team
    belongs_to :event
  
    validates :team_id, uniqueness: { scope: :event_id }
  end
  