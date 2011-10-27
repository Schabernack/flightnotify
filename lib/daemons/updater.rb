#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

require File.dirname(__FILE__) + "/../../config/environment"       

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
                                                                    
  # Replace this with your code
  Rails.logger.auto_flushing = true                                 
  Rails.logger.info "This daemon is still running at #{Time.now}.\n"
  
  flight = Flight.next_for_update

  new_flight = Flight.get_details(flight.flight_number)

  flight.update_attributes(:actual_departure => new_flight.actual_departure,
                          :actual_arrival => new_flight.actual_arrival,
                          :planned_departure => new_flight.planned_departure,
                          :planned_arrival => new_flight.planned_arrival)
  Rails.logger.info "HALLO123"
  Rails.logger.info "UPDATED FLIGHT WITH ID #{flight.id}" 
  
  sleep 10
end