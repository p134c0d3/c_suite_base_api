class UserTeam < ApplicationRecord
    belongs_to :user
    belongs_to :team
  
    validates_uniqueness_of :user, scope: :team
  end