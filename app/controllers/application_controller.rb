class ApplicationController < ActionController::Base
  protect_from_forgery

  require "rubygems"
  require "bundler/setup"
  require "nokogiri"
  require "open-uri"
  
  def index
    
  end
 
  def search
    @response = Nokogiri::HTML(open('http://www.google.com/search?q='+params[:query].gsub(/ /,'')))

    @bla =  @response.at_css("title").text
    @response.css('.rbt').each do |foo|
      
      @flight = foo.at_css('b').text                               
      @from = foo.at_css("tr:nth-child(3) td:nth-child(2)") .text
      @to = foo.at_css("tr:nth-child(6) td:nth-child(2)").text
      
      
      @departure = foo.at_css("tr:nth-child(2) td:nth-child(3)").text
      @plannedDeparture = foo.at_css("tr:nth-child(2) td:nth-child(4)").text
      
      @arrival = foo.at_css("tr:nth-child(5) td:nth-child(3)").text
      @plannedArrival = foo.at_css("tr:nth-child(5) td:nth-child(4)").text
    end
    
  end
  
end
