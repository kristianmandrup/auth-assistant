require 'active_support/railtie'
require 'rails3_plugin_toolbox'

Rails3::PluginExtender.new do
  # extend action_controller with methods from some modules
  # extend_rails(:controller) do
  #   extend_from_module AuthAssistant, :role
  #   extend_from_module AuthAssistant::Controller, :ability
  #   extend_from_module AuthAssistant::Helper, :role, :local_host, :auth_label
  #   extend_from_module AuthAssistant::Link, :session, :registration, :rest, :session          
  # end  

  # extend action_view with methods from some modules
  extend_rails(:view) do
    extend_from_module AuthAssistant::View, :roles, :user_action_menu
    extend_from_module AuthAssistant::Helper, :role
    # extend_from_module AuthAssistant::Link, :session, :registration, :rest, :session
  end  
  
  after :initialize do   
    puts "Rails app initialized"
    require_all File.dirname(__FILE__) + '/after_init'
  end
end
