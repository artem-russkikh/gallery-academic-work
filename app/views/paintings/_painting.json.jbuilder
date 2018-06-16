json.extract! painting, :id, :title, :painting_kind_id, :user_id, :created_at, :updated_at
json.url painting_url(painting, format: :json)
