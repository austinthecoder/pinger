class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.belongs_to :location
      t.belongs_to :email_callback
      t.string :code_is_not
      t.integer :times

      t.timestamps
    end
    add_index :alerts, :location_id
    add_index :alerts, :email_callback_id
  end
end
