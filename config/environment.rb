# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Flightnotify::Application.initialize!

# Timezone
Time.zone = "Berlin"
