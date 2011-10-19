class CreateEmailCallbacks < ActiveRecord::Migration
  def change
    create_table :email_callbacks do |t|
      t.string :to
      t.string :label

      t.timestamps
    end
  end
end
