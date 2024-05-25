class CreateUserRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_roles do |t|
      t.references :user_id, null: false, foreign_key: true
      t.references :role_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
