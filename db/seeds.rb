# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Departure.destroy_all;
Station.destroy_all;
Trip.destroy_all;
Track.destroy_all;
Status.destroy_all;

#Import from CSV
require 'csv';
file = File.read("#{Rails.root}/db/Departures.csv");
csv = CSV.parse(file, :headers => true);


csv.each do |row|
	#Stations
	Station.find_or_create_by(name:row["Origin"])
	Station.find_or_create_by(name:row["Destination"])
	
	#Status
	Status.find_or_create_by(given:row["Status"])
	
	#Track
	origin = Station.find_by(name:row["Origin"])
	if row["Track"] != nil
		Track.find_or_create_by(number:row["Track"].to_i,station_id:origin.id)
	end
	
	#Trips
	destination = Station.find_by(name:row["Destination"])
	Trip.find_or_create_by(number:row["Trip"], origin_id:origin.id, destination_id:destination.id)

	#Departures
	time = Time.at(row["ScheduledTime"].to_i)
	trip = Trip.find_by(number:row["Trip"])
	track = Track.find_by(number:row["Track"].to_i)
	status = Status.find_by(given:row["Status"])
	departure = Departure.find_or_create_by(status_id:status.id,trip_id:trip.id,lateness:row["Lateness"].to_i, scheduledtime:time)
	if track != nil
		departure.update(track_id:track.id)
	end
end

#Other Statuses
Status.find_or_create_by(given:"On Time");
Status.find_or_create_by(given:"Cancelled");
Status.find_or_create_by(given:"Arriving");
Status.find_or_create_by(given:"End");
Status.find_or_create_by(given:"Now Boarding");
Status.find_or_create_by(given:"Info to follow");
Status.find_or_create_by(given:"Arrived");
Status.find_or_create_by(given:"All Aboard");
Status.find_or_create_by(given:"TBD");
Status.find_or_create_by(given:"Departed");
Status.find_or_create_by(given:"Delayed");
Status.find_or_create_by(given:"Late");
Status.find_or_create_by(given:"Hold");