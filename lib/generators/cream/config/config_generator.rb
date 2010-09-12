require 'sugar-high/file'
require 'auth-assistant'

module AuthAssist 
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc "Configures Devise and Users" 

      # Role Strategy
      argument     :strategy,     :type => :string,   :desc => "Role strategy to use",  
                   :default => 'role_string'

      # Init Devise
      class_option :init_devise,  :type => :boolean,  :desc => "Initialize devise",     
                   :default => false, :aliases => "-d", 

      # Create Admin user
      class_option :admin_user,   :type => :boolean,  :desc => "Create admin user",     
                   :default => false

      # ORM to use
      class_option :orm,          :type => :string,   :desc => "ORM to use",            
                   :default => 'active_record'

      def main_flow  
        init_devise if init_devise?
        create_users
        configure_permission_system
        configure_locale
      end

      # -----------------      
      protected

      def init_devise        
        invoke 'devise_install'
      end

      def create_users
        create_user
        create_admin_user if admin_user?
      end

      def configure_permission_system
        configure_exception_handling
      end

      def configure_locale
        copy_file "config/locales/en.yml".up(4), "config/locales/auth_assist.en.yml"
      end

      # -----------------
      private

      # Must be ORM specific!
      def create_user
        invoke 'devise User'
      end

      def create_admin_user
        invoke 'devise Admin' 
      end      

      # CanCan permissions configuration
      def configure_exception_handling         
        inject_into_file "app/controllers/application_controller.rb", :after => "ActionController::Base\n" do
          %{
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
}
        end
      end

      # options
      # -----------------
      
      def admin_user?
        options[:admin]
      end

      def init_devise?
        options[:devise]
      end

      def here
        File.dirname(__FILE__)
      end

      def root_dir
        File.dirname(__FILE__).up(4)
      end
    end
  end
end