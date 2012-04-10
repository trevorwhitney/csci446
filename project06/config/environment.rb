# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['RECAPTCHA_PUBLIC_KEY'] = '6LcEBtASAAAAALt_Fk70tCa7sejuu4lwwYMzIaFK'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6LcEBtASAAAAAB2Wlr7x3afVQTZ-7ItXUdTbnkkJ'

# Initialize the rails application
Gamez::Application.initialize!