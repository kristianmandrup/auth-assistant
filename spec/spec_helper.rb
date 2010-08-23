require 'rspec'
require 'rspec/autorun' 
# require 'auth-assistant'

module RSpec
  module ActionView
    module Macro
      def with_action_view &block 
        block.call(ActionViewTester.new)
      end
    
      def setup_action_view &block
        ActionViewTester.instance_eval(&block)
      end
    end
  end
end

RSpec.configure do |config|
  config.mock_with :mocha 
  config.extend RSpec::ActionView::Macro
end

