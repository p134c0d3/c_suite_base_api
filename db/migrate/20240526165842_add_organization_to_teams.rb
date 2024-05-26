class AddOrganizationToTeams < ActiveRecord::Migration[7.1]
  def change
    add_reference :teams, :organization, null: false, foreign_key: true
  end
end
