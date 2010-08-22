require 'rspec'
require 'rspec/autorun' 
require 'auth-assistant'

require 'active_support'
require 'action_controller'
require 'action_view'
# require 'active_record'
# require 'action_mailer'
require 'active_support/railtie'
# require 'rails/all'


module Minimal
  class Application < Rails::Application
    config.active_support.deprecation = :log
  end
end


RSpec.configure do |config|
  config.mock_with :mocha
end

