class Flight < ActiveRecord::Base 
  validates_presence_of :name, :on => :create, :message => "konnte FLug nicht finden."
  
  def get_details(flight_number)
    response = Nokogiri::HTML(open('http://www.google.com/search?q='+flight_number.gsub(/ /,'')))

    response.css('.rbt').each do |foo|
      
      self.name = foo.at_css('b').text                               
      self.departure_location = foo.at_css("tr:nth-child(3) td:nth-child(2)") .text
      self.arrival_location = foo.at_css("tr:nth-child(6) td:nth-child(2)").text
                                                  
      departure_day = foo.at_css("tr:nth-child(3) td:nth-child(3)").text
      departure_time = foo.at_css("tr:nth-child(2) td:nth-child(3)").text
      self.actual_departure = DateTime.strptime(departure_day+" "+departure_time, "%b %d %I:%M%P")
                                                                         
      arrival_day = foo.at_css("tr:nth-child(6) td:nth-child(3)").text
      arrival_time = foo.at_css("tr:nth-child(5) td:nth-child(3)").text
      self.actual_arrival = DateTime.strptime(arrival_day+" "+arrival_time, "%b %d %I:%M%P")
      
      planned_departure_time = foo.at_css("tr:nth-child(2) td:nth-child(4)").text.sub("(was ","").sub(")","")
      logger.info planned_departure_time
      if !planned_departure_time.blank?
        self.planned_departure = DateTime.strptime(departure_day+" "+planned_departure_time, "%b %d %I:%M%P")
      else
        self.planned_departure = self.actual_departure
      end
      
      planned_arrival_time = foo.at_css("tr:nth-child(5) td:nth-child(4)").text.sub("(was ","").sub(")","")  
      logger.info planned_arrival_time
      if !planned_arrival_time.blank? 
        self.planned_arrival = DateTime.strptime(arrival_day+" "+planned_arrival_time, "%b %d %I:%M%P")      
      else
        self.planned_arrival = self.actual_arrival
      end
                                                                         
      self.departure_terminal = foo.at_css("tr:nth-child(2) td:nth-child(5)").text
      self.arrival_terminal = foo.at_css("tr:nth-child(5) td:nth-child(5)").text
    end
    
  end
end
