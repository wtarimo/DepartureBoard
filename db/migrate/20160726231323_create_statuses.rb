class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :given
      t.text :info

      t.timestamps null: false
    end
  end
end
