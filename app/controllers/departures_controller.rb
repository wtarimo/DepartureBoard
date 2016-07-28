class DeparturesController < ApplicationController
  http_basic_authenticate_with name: "MBTAAdmin", password: "MBTA2016"
  before_action :set_departure, only: [:show, :edit, :update, :destroy]

  # GET /departures
  # GET /departures.json
  def index
    @departures = Departure.all
  end

  # GET /departures/1
  # GET /departures/1.json
  def show
  end

  # GET /departures/new
  def new
    @departure = Departure.new
    @departure.scheduledtime = DateTime.now.strftime("%d/%m/%Y %H:%M")
    @status_options = [["Select Status",nil]] + Status.all.map {|st| [st.given, st.id]}
    @trip_options = [["Select Trip",nil]] + Trip.all.map {|tr| ["#{tr.number}: From #{Station.find(tr.origin_id).name} To #{Station.find(tr.destination_id).name}", tr.id]}
  end

  # GET /departures/1/edit
  def edit
    @departure.scheduledtime = DateTime.now.strftime("%d/%m/%Y %H:%M")
    @status_options = [["Select Status",nil]] + Status.all.map {|st| [st.given, st.id]}
    @trip_options = [["Select Trip",nil]] + Trip.all.map {|tr| ["#{tr.number}: From #{Station.find(tr.origin_id).name} To #{Station.find(tr.destination_id).name}", tr.id]}
  end

  # POST /departures
  # POST /departures.json
  def create
    if departure_params[:trip_id] != ""
      trip = Trip.find(departure_params[:trip_id])
      track = Track.find_by(station_id:trip.origin_id, number:departure_params[:track_id])
    end
    @departure = Departure.new(trip_id:departure_params[:trip_id],status_id:departure_params[:status_id],\
      lateness:departure_params[:lateness],info:departure_params[:info],track_id:track ? track.id : nil,\
      scheduledtime:Time.parse(departure_params[:scheduledtime]))

    respond_to do |format|
      if @departure.save
        format.html { redirect_to @departure, notice: 'Departure was successfully created.' }
        format.json { render :show, status: :created, location: @departure }
      else
        @departure.scheduledtime = DateTime.now.strftime("%d/%m/%Y %H:%M")
        @status_options = [["Select Status",nil]] + Status.all.map {|st| [st.given, st.id]}
        @trip_options = [["Select Trip",nil]] + Trip.all.map {|tr| ["#{tr.number}: From #{Station.find(tr.origin_id).name} To #{Station.find(tr.destination_id).name}", tr.id]}
        format.html { render :new }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departures/1
  # PATCH/PUT /departures/1.json
  def update
    if departure_params[:trip_id] != ""
      trip = Trip.find(departure_params[:trip_id])
      track = Track.find_by(station_id:trip.origin_id, number:departure_params[:track_id])
    end
    @departure = Departure.new(trip_id:departure_params[:trip_id],status_id:departure_params[:status_id],\
      lateness:departure_params[:lateness],info:departure_params[:info],track_id:track ? track.id : nil,\
      scheduledtime:Time.parse(departure_params[:scheduledtime]))
    respond_to do |format|
      if @departure.update(departure_params)
        format.html { redirect_to @departure, notice: 'Departure was successfully updated.' }
        format.json { render :show, status: :ok, location: @departure }
      else
        @departure.scheduledtime = DateTime.now.strftime("%d/%m/%Y %H:%M")
        @status_options = [["Select Status",nil]] + Status.all.map {|st| [st.given, st.id]}
        @trip_options = [["Select Trip",nil]] + Trip.all.map {|tr| ["#{tr.number}: From #{Station.find(tr.origin_id).name} To #{Station.find(tr.destination_id).name}", tr.id]}
        format.html { render :edit }
        format.json { render json: @departure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departures/1
  # DELETE /departures/1.json
  def destroy
    @departure.destroy
    respond_to do |format|
      format.html { redirect_to departures_url, notice: 'Departure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departure
      @departure = Departure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departure_params
      params.require(:departure).permit(:scheduledtime,:trip_id, :lateness, :track_id, :info, :status_id)
    end
end
