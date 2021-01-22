class AddTimestampsToComments < ActiveRecord::Migration[5.1]
  def change
    change_table :comments do |t|
      t.timestamps
    end
  end
end
