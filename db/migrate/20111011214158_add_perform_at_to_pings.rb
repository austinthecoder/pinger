class AddPerformAtToPings < ActiveRecord::Migration
  def change
    add_column :pings, :perform_at, :datetime
  end
end
