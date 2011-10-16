class FlightsController < ApplicationController
  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all

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

  # GET /flights/new
  # GET /flights/new.json
  def new
    @flight = Flight.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flight }
    end
  end

  # GET /flights/1/edit
  def edit
    @flight = Flight.find(params[:id])
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(params[:flight])
    #logger.info @flight.inspect
    @response = Nokogiri::HTML(open('http://www.google.com/search?q='+@flight.flight_number.gsub(/ /,'')))

    @response.css('.rbt').each do |foo|
      
      @flight.name = foo.at_css('b').text                               
      @flight.departure_location = foo.at_css("tr:nth-child(3) td:nth-child(2)") .text
      @flight.arrival_location = foo.at_css("tr:nth-child(6) td:nth-child(2)").text
                                                  
      departure_day = foo.at_css("tr:nth-child(3) td:nth-child(3)").text
      departure_time = foo.at_css("tr:nth-child(2) td:nth-child(3)").text
      @flight.actual_departure = DateTime.strptime(departure_day+" "+departure_time, "%b %d %I:%M%P")
                                                                         
      arrival_day = foo.at_css("tr:nth-child(6) td:nth-child(3)").text
      arrival_time = foo.at_css("tr:nth-child(5) td:nth-child(3)").text
      @flight.actual_arrival = DateTime.strptime(arrival_day+" "+arrival_time, "%b %d %I:%M%P")
      
      planned_departure_time = foo.at_css("tr:nth-child(2) td:nth-child(4)").text.sub("(was ","").sub(")","")
      logger.info planned_departure_time
      if !planned_departure_time.blank?
        @flight.planned_departure = DateTime.strptime(departure_day+" "+planned_departure_time, "%b %d %I:%M%P")
      else
        @flight.planned_departure = @flight.actual_departure
      end
      
      planned_arrival_time = foo.at_css("tr:nth-child(5) td:nth-child(4)").text.sub("(was ","").sub(")","")  
      logger.info planned_arrival_time
      if !planned_arrival_time.blank? 
        @flight.planned_arrival = DateTime.strptime(arrival_day+" "+planned_arrival_time, "%b %d %I:%M%P")      
      else
        @flight.planned_arrival = @flight.actual_arrival
      end
                                                                         
      @flight.departure_terminal = foo.at_css("tr:nth-child(2) td:nth-child(5)").text
      @flight.arrival_terminal = foo.at_css("tr:nth-child(5) td:nth-child(5)").text
    end

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
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
