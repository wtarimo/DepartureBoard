class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.references :trip, index: true, foreign_key: true
      t.integer :lateness, :default => 0
      t.references :track, index: true, foreign_key: true
      t.text :info
      t.references :status, index: true, foreign_key: true
      t.datetime :scheduledtime

      t.timestamps null: false
    end
  end
end
