class FlightMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def notification_email(flight)
    @flight = flight           
    mail(:to => "reinerzufall4u@gmail.com", :subject => "Ihr Fluginformationen")
    
  end
end
