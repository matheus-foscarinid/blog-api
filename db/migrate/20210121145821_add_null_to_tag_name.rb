class AddNullToTagName < ActiveRecord::Migration[5.1]
  def change
    change_column :tags, :name, :string, limit: 20
  end
end
