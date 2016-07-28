json.array!(@stations) do |station|
  json.extract! station, :id, :name, :info
  json.url station_url(station, format: :json)
end
