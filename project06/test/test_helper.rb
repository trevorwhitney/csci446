ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  setup :activate_authlogic

  fixtures :all

  def login_member
    UserSession.create(users(:member))
  end

  def login_admin
    UserSession.create(users(:admin))
  end 

end
