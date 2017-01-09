json.extract! comment, :id, :type, :title, :content, :active, :created_at, :updated_at
json.url comment_url(comment, format: :json)