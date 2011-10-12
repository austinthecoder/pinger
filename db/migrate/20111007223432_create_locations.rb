class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :url
      t.string :method
      t.integer :seconds

      t.timestamps
    end
  end
end
