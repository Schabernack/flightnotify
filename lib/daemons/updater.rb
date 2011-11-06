#!/usr/bin/env ruby
  
# You might want to change this
ENV["RAILS_ENV"] ||= "development"

#Rails.logger.auto_flushing = true

require File.dirname(__FILE__) + "/../../config/environment"       

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  
  flight = Flight.next_for_update   
  
  unless flight.nil? 
    Rails.logger.info "checking #{flight.name} (#{flight.id})" 
    
    new_flight = Flight.get_details(flight.flight_number)
  
    if !new_flight.actual_departure.nil? 
      
      if flight.flight_details_changed?(new_flight) 
        
        Rails.logger.info flight.inspect
        Rails.logger.info new_flight.inspect
        
        Rails.logger.info "starte update_attributes"
       
        flight.update_attributes(:actual_departure => new_flight.actual_departure,
                                :actual_arrival => new_flight.actual_arrival,
                                :planned_departure => new_flight.planned_departure,
                                :planned_arrival => new_flight.planned_arrival) 
                    
                                                                              
       
        
        Rails.logger.info "fertig mit update_attributes"
        FlightMailer.update_email(flight).deliver
        
      else   
        Rails.logger.info "nichts hat sich geaendert #{flight.name} (#{flight.id})" 
        flight.touch
        
      end
    end
  else
    Rails.logger.info "gerade kein Flug zum updaten" 
  end
  sleep 20
end

