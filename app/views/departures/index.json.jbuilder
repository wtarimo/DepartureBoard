json.array!(@departures) do |departure|
  json.extract! departure, :id, :trip_id, :lateness, :track_id, :info, :status_id
  json.url departure_url(departure, format: :json)
end
