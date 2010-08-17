require 'rspec'
require 'rspec/autorun' 
require 'auth-assistant'
require 'generator_spec_helper'

RSpec.configure do |config|
  config.mock_with :mocha  
  config.include(RSpec::Rails::GeneratorMatchers)
end

