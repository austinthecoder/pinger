class ChangeMethodToHttpMethod < ActiveRecord::Migration
  def up
    rename_column :locations, :method, :http_method
  end

  def down
    rename_column :locations, :http_method, :method
  end
end
