require 'generators/auth_assistant/migration_helper'

module AuthAssistant
  module Generators
    class ConfigGenerator < Rails::Generators::NamedBase
      desc "Generates user role migration and matching auth configuration initializer" 

      class_option :migration, :type => :boolean, :aliases => "-m", :default => false,
                                     :desc => "To generate a user role migration."


      def self.source_root
        @_devise_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_initializer
        template "auth_assistant", "config/initializers"
      end 

      def run_migration
        return nil if !options[:migration]        
        send :"#{name}_migration"          
      end 
      
      protected
        include AuthAssistant::MigrationHelper
        
    end
  end
end