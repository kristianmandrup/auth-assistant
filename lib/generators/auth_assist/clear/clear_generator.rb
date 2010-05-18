require 'generators/migration_helper'
require 'generators/reverse_migrations'
require 'generators/role_migrations'
require 'rake'

module AuthAssist
  module Generators
    class ClearGenerator < Rails::Generators::NamedBase       

      desc "Clears the rails project from any artifacts generated by auth_assist" 

      class_option :migration, :type => :boolean, :aliases => "-m", :default => true,
                                     :desc => "To generate a migration to clear the user role."

      def self.source_root
        @source_root ||= File.expand_path("../../templates", __FILE__)
      end
            
      def generate_clear_migration 
        return nil if !options[:migration]        
        clazz = AuthAssist::RoleMigrations.clazz(name)
        obj = clazz.new(self)
        obj.generate_reverse_migration
        obj.reverse_configure if obj.respond_to? :reverse_configure
      end
      
      include ::AuthAssist::MigrationHelper      
    end
  end
end