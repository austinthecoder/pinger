class CreatePings < ActiveRecord::Migration
  def change
    create_table :pings do |t|
      t.belongs_to :location
      t.datetime :performed_at
      t.string :response_status_code

      t.timestamps
    end
  end
end
