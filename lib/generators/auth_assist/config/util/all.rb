module AuthAssist 
  module Generators
    class ConfigGenerator
      module PermissionUtil
        # def configure_permission_system
        # end
        
        def create_default_ability_setup
          copy_file 'ability.rb', 'app/models/ability.rb'
  
        def create_default_permits        
          copy_file 'permits.rb', 'lib/permits.rb'
        end 
        
        def configure_exception_handling         
          inject_into_file "app/controllers/application_controller.rb", :after => "ActionController::Base\n" do
            File.read(self.class.templates_dir, 'permission_exception.rb')
          end
        end
      end
    
      module Locale
        def copy_locale
          locale_file = File.expand_path("config/locales/en.yml".up(4), LOCATION)
          puts locale_file        
          copy_file locale_file, "config/locales/auth_assist.en.yml"    
        end
      end    
      
      module InitDevise
        def init_devise?
          options[:devise]
        end

        def init_devise
          return if 
          run 'rails g devise_install'        
          create_user
          create_admin_user
        end
      end

      module CreateUsers
        def create_users
          create_user
          create_admin_user if admin_user?
        end

        def admin_user?
          options[:admin]
        end

        # Must be ORM specific!
        def create_user
          # run 'rails g devise User'
        end

        def create_admin_user
          # run 'rails g devise Admin' 
        end      
      end
        
      include PermissionUtil
      include LocaleUtil
      include InitDevise
      include CreateUsers      
    end
  end
end