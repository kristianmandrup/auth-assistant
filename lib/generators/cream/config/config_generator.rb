require 'sugar-high/file'
require 'auth-assistant'

module Cream 
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc "Configures Devise and Users" 

      # Role Strategy
      argument     :strategy,       :type => :string,   :desc => "Role strategy to use",  
                   :default => 'role_string'

      # Init Devise
      class_option :init_devise,    :type => :boolean,  :desc => "Initialize devise",     
                   :default => false, :aliases => "-d", 

      # Create Admin user
      class_option :admin_user,     :type => :boolean,  :desc => "Create admin user",     
                   :default => false

      # Default roles
      class_option :default_roles,  :type => :boolean,  :desc => "Create default roles :admin and :guest",     
                   :default => true

      class_option :roles_config,  :type => :boolean,  :desc => "Configure roles or not",     
                   :default => true

      class_option :permission_config,  :type => :boolean,  :desc => "Configure permissions or not",     
                   :default => true

      class_option :roles,          :type => :array,    :desc => "Create default roles :admin and :guest",     
                   :default => []

      # ORM to use
      class_option :orm,          :type => :string,   :desc => "ORM to use",            
                   :default => 'active_record'

      def main_flow  
        init_devise if init_devise?
        configure_devise_gems
        create_users
        # configure_roles if roles_config?       
        # configure_permission_system if permission_config?
        # configure_locale
      end

      # -----------------      
      protected

      def init_devise        
        invoke 'devise_install'
      end

      ORM_MAP = {
        :data_mapper  => 'dm-devise',
        :mongo_mapper => 'mm-devise',
        :mongoid      => 'rails3-mongoid-devise'                
      }

      def configure_devise_gems
        gem_name = ORM_MAP[orm]
        gem gem_name if !gem_name
        gem 'cancan'
        gem "roles-#{orm}"
        run "bundle install"
      end

      def create_users
        create_user
        create_admin_user if admin_user?
      end

      def configure_roles
        invoke "#{orm}:roles --strategy #{strategy} --roles #{roles} #{default_roles}"
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

      def default_roles
        options[:default_roles] ? '--default-roles' : '--no-default-roles'
      end

      def roles
        options[:roles].join(' ')

      def orm
        options[:orm]
      end

      def roles_config?
        options[:roles_config]
      end

      def permission_config?
        options[:permission_config]
      end
      
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