require 'generators/auth_assist/string_ext'
require_all File.dirname __FILE__, '/util'

LOCATION = __FILE_

# TODO
# exception handling - 

module AuthAssist 
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc "Configures devise with a named strategy" 

      # Role Strategy
      argument :strategy,   :type => :string,   :desc => "Role strategy to use",  :default => 'role_string'

      # Init Devise
      class_option :devise, :type => :boolean,  :desc => "Initialize devise.",    :default => false, :aliases => "-d", 
      # Create Admin user
      class_option :admin,  :type => :boolean,  :desc => "Create admin user.",    :default => false
      # ORM to use
      class_option :orm,    :type => :string,   :desc => "ORM to use",            :default => 'active_record'

      def self.templates_dir
        File.expand_path(File.join(LOCATION.up(1), 'templates')
      end            

      source_root templates_dir

      def main_flow  
        init_devise if init_devise?
        create_users
        set_orm
      end
    end
  end
end