require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  fixtures :flights
  
  test "flight is not valid without a name" do
    flight = Flight.new(:flight_number => flights(:hamburg).flight_number)
    
    assert !flight.save
  end
  
  test "flight is not valid wihtout a departure time" do
    flight = Flight.new(:flight_number => flights(:hamburg).flight_number,
                        :name => flights(:hamburg).name)

    assert !flight.save
    assert_equal "can't be blank", flight.errors[:actual_departure].join('; ')
  end
end
