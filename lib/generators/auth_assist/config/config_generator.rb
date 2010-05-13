require 'generators/migration_helper'
require 'auth_assistant/model/user_config'

module AuthAssist
  module Generators
    class ConfigGenerator < Rails::Generators::NamedBase
      desc "Generates user role migration and matching auth configuration initializer" 

      class_option :devise, :type => :boolean, :aliases => "-d", :default => false,
                                     :desc => "Initialize devise."

      class_option :migration, :type => :boolean, :aliases => "-m", :default => false,
                                     :desc => "To generate a user role migration."
            
      def self.source_root
        @source_root ||= File.expand_path("../../templates", __FILE__)
      end
      
      def create_initializer
        if options[:devise]
          run 'rails g devise_install'        
          run 'rails g devise User'
        end
        template "auth_assistant.rb", "config/initializers/auth_assistant.rb"
      end 

      def copy_locale
        locale_file = File.expand_path("../../../../../config/locales/en.yml", __FILE__)
        puts locale_file        
        copy_file locale_file, "config/locales/auth_assist.en.yml"    
      end
      
      def run_migration
        return nil if !options[:migration]        
        send :"#{name}_migration"          
      end 

      def self.banner
        "#{$0} auth_assist:config strategy [admin_field, role_field, roles_field, roles_mask, role_assignment]"
      end
      
      protected
        include ::AuthAssist::MigrationHelper
        
    end
  end
end