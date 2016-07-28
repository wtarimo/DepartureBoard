class HomeController < ApplicationController
	def index
	    @departures = Departure.all
	end
end
