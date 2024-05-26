class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :location, null: false
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
