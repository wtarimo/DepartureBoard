class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :number
      t.integer :origin_id
      t.integer :destination_id
      t.text :info

      t.timestamps null: false
    end
  end
end
