require 'test_helper'

class FlightsControllerTest < ActionController::TestCase
  setup do
    @flight = flights(:hamburg)
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  

end
