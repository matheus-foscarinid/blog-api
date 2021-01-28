json.(@post, :id, :title, :description, :created_at, :updated_at, :user)
json.comments(@comments, :id, :text, :user)
json.tags(@tags, :id, :name)