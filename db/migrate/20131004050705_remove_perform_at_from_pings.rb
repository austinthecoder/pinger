class RemovePerformAtFromPings < ActiveRecord::Migration
  def up
    remove_column :pings, :perform_at
  end

  def down
    add_column :pings, :perform_at, :datetime
  end
end
