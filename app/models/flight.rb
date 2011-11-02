class Flight < ActiveRecord::Base
  require 'rubygems'   
  require 'nokogiri'
  require "open-uri"

  has_one :subscription
  has_one :user, :through => :subscription

  validates_presence_of :name, :on => :create, :message => "konnte FLug nicht finden."
  validates_presence_of :actual_departure, :on => :create, :message => "can't be blank"

  belongs_to :user
  
  def self.next_for_update
    Flight.first(:conditions => ["actual_departure >= ? AND updated_at <= ?", Time.now, Time.now-10.minutes], :order => "updated_at ASC")
  end 
  
  def self.get_details(flight_number)  
    flight = Flight.new 
    flight.flight_number = flight_number

    response = Nokogiri::HTML(open('http://www.google.com/search?q='+flight_number.gsub(/ /,'')))
    
    response.css('.rbt').each do |foo|
     
      
      flight.name = foo.at_css('b').text                               

      flight.departure_location = foo.at_css("tr:nth-child(3) td:nth-child(2)") .text
      flight.arrival_location = foo.at_css("tr:nth-child(6) td:nth-child(2)").text
                                                  
      departure_day = foo.at_css("tr:nth-child(3) td:nth-child(3)").text
      departure_time = foo.at_css("tr:nth-child(2) td:nth-child(3)").text
      flight.actual_departure = DateTime.strptime(departure_day+" "+departure_time, "%b %d %I:%M%P").change(:offset => DateTime.now.offset)
                                                                               
      arrival_day = foo.at_css("tr:nth-child(6) td:nth-child(3)").text
      arrival_time = foo.at_css("tr:nth-child(5) td:nth-child(3)").text
      flight.actual_arrival = DateTime.strptime(arrival_day+" "+arrival_time, "%b %d %I:%M%P").change(:offset => DateTime.now.offset)
      
      planned_departure_time = foo.at_css("tr:nth-child(2) td:nth-child(4)").text.sub("(was ","").sub(")","")

      if !planned_departure_time.blank?
        flight.planned_departure = DateTime.strptime(departure_day+" "+planned_departure_time, "%b %d %I:%M%P").change(:offset => DateTime.now.offset)
      else
        flight.planned_departure = flight.actual_departure
      end
      
      planned_arrival_time = foo.at_css("tr:nth-child(5) td:nth-child(4)").text.sub("(was ","").sub(")","")  

      if !planned_arrival_time.blank? 
        flight.planned_arrival = DateTime.strptime(arrival_day+" "+planned_arrival_time, "%b %d %I:%M%P").change(:offset => DateTime.now.offset)      
      else
        flight.planned_arrival = flight.actual_arrival
      end
                                                                  
      flight.departure_terminal = foo.at_css("tr:nth-child(2) td:nth-child(5)").text
      flight.arrival_terminal = foo.at_css("tr:nth-child(5) td:nth-child(5)").text
    end
    flight
  end   

end
