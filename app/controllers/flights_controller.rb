class FlightsController < ApplicationController
  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all
    @nextFlight = Flight.next_for_update
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flights }
    end
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
    @flight = Flight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flight }
    end
  end 
  
  def preview
    @flight = Flight.get_details(params[:flight][:flight_number])    
    respond_to do |format|
      if @flight.save
        session[:flight_id] = @flight.id
        
        format.html #   preview.html.erb 
        format.js
        format.json { render json: @flight }
      end
    end
  end

  # GET /flights/new
  # GET /flights/new.json
  def new
    @flight = Flight.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flight }
    end
  end
  
  def subscribe
    @flight = Flight.find(session[:flight_id]) 
    user = User.find_or_create_by_mail(params[:email])
    
    @flight.create_subscription(:user => user, :del_token => SecureRandom.hex(12))
                           
    if FlightMailer.notification_email(@flight).deliver
      reset_session
    end
    
    respond_to do |format|
      if @flight.save            
        format.html { redirect_to root_path, notice: 'Flight was successfully created.' }
        format.json { render json: @flight, status: :created, location: @flight }
      else
        format.html { render action: "new" }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end           
    end
    
  end

  # PUT /flights/1
  # PUT /flights/1.json
  def update
    @flight = Flight.find(params[:id])

    respond_to do |format|
      if @flight.update_attributes(params[:flight])
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy

    respond_to do |format|
      format.html { redirect_to flights_url }
      format.json { head :ok }
    end
  end
end
