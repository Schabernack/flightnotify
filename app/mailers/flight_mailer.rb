class FlightMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def notification_email(flight)
    @flight = flight           
    mail(:to => "flugstatusmailer@gmail.com", :subject => "Ihre Fluginformationen")
    
  end
end
