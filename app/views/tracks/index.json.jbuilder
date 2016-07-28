json.array!(@tracks) do |track|
  json.extract! track, :id, :number, :info, :station_id
  json.url track_url(track, format: :json)
end
