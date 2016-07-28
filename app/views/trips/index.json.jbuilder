json.array!(@trips) do |trip|
  json.extract! trip, :id, :number, :origin_id, :destination_id, :scheduled_time, :info
  json.url trip_url(trip, format: :json)
end
