class Organization < ApplicationRecord
    has_many :users
    has_many :teams
    has_many :events

    validates :name, presence: true
end
