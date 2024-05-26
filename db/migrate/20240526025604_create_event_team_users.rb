class CreateEventTeamUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :event_team_users do |t|
      t.references :event, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
