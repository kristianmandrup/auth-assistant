require 'rspec/core'    
require 'generator-spec'
require 'auth-assistant'

RSpec::Generator.configure do |config|
  config.debug = false
  config.remove_temp_dir = false # true
  config.default_rails_root(__FILE__) 
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  
end