json.(@post, :id, :title, :description, :created_at, :updated_at)
json.comments(@comments, :id, :text)
json.tags(@tags, :id, :name)