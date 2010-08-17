require 'auth_assistant/model/user_config'

module AuthAssist 
  module Generators
    class ConfigGenerator < Rails::Generators::NamedBase
      desc "Generates user role migration and matching auth configuration initializer" 

      class_option :devise, :type => :boolean, :aliases => "-d", :default => false,
                                     :desc => "Initialize devise."

      class_option :admin, :type => :boolean, :aliases => "-a", :default => false,
                                    :desc => "Creae admin user."


      class_option :migration, :type => :boolean, :aliases => "-m", :default => true,
                                     :desc => "To generate a user role migration."
            
      def self.source_root
        @source_root ||= File.expand_path("../../templates", __FILE__)
      end

      def init_devise
        return if !options[:devise]
        run 'rails g devise_install'        
        run 'rails g devise User'
      end
      
      def create_initializer
        # prefixing with x should make sure it is run after devise initializer
        template "auth_assistant.rb", "config/initializers/x_auth_assistant.rb"
      end 

      def create_default_ability_setup
        copy_file 'ability.rb', 'app/models/ability.rb'
        
      def create_default_permits        
        copy_file 'permits.rb', 'lib/permits.rb'
      end

      def create_admin_user
        return if !options[:admin]
        run 'rails g devise Admin' if options[:admin]                
        # use STI
        gsub_file 'app/models/admin.rb', /ActiveRecord::Base/, 'User'        
      end

      def copy_locale
        locale_file = File.expand_path("../../../../../config/locales/en.yml", __FILE__)
        puts locale_file        
        copy_file locale_file, "config/locales/auth_assist.en.yml"    
      end
      
      def self.banner
        "#{$0} auth_assist:config strategy [admin_field, role_field, roles_field, roles_mask, role_assignment, multi_role_assignment]"
      end              
    end
  end
end