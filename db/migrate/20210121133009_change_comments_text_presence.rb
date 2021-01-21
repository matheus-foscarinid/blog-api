class ChangeCommentsTextPresence < ActiveRecord::Migration[5.1]
  def change
    change_column_null :comments, :text, false
  end
end
