json.array!(@statuses) do |status|
  json.extract! status, :id, :given, :info
  json.url status_url(status, format: :json)
end
