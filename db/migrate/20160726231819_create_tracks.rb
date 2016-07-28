class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :number
      t.text :info
      t.references :station, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
