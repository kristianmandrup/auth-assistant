module AuthAssistant::Configure
  module Rails
    class << self
      include Rails::Plugin::Toolbox::Extender

      def do!
        after(:initialize) do
          # include ???
        end

        extend_rails(:controller) do
          extend_from_module AuthAssistant, :role
          extend_from_module AuthAssistant::Controller, :ability
          extend_from_module AuthAssistant::Helper, :role, :local_host, :auth_label
          extend_from_module AuthAssistant::Link, :session, :registration, :rest, :session          
        end  

        # extend action_view with methods from some modules
        extend_rails(:view) do
          extend_from_module AuthAssistant::View::Helpers, :role, :area
          extend_from_module AuthAssistant::Link, :session, :registration, :rest, :session
        end
      end    
    end
  end                          
end

AuthAssistant::Configure::Rails.do!