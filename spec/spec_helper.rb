require 'rspec'
require 'rspec/autorun' 
require 'auth-assistant'
require 'rspec-action_view'

RSpec.configure do |config|
  config.mock_with :mocha 
  # config.extend RSpec::ActionView::Macro
end

