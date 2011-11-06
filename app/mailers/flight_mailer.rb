class FlightMailer < ActionMailer::Base
  default_url_options[:host] = "flightnotify.dev"
  default from: "from@example.com"
  
  def notification_email(flight)
    @flight = flight           
    mail(:to => flight.user.mail, :subject => "Ihre Fluginformationen")  
  end
  
  def update_email(flight)
    @flight = flight
    mail(:to => flight.user.mail, :subject => "Flugstatus update")
  end
end
