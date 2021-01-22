class CreatePostTagJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :posts, :tags do |t|
      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
