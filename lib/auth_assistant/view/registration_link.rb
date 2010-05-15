module AuthAssistant
  module ViewHelpers
    module RegistrationLink

      def sign_up_link(options = {})
        label = options[:label] || auth_labels[:sign_up]
        get_link(label, registration_path options[:role])
      end

      def edit_registration_link(options = {})  
        label = options[:label] || auth_labels[:edit_registration]
        get_link(label, edit_registration_path options[:role])
      end

      alias_method :register_link, :sign_up_link    
      alias_method :edit_profile_link, :edit_registration_link

      protected
        def registration_path(role) 
          role == 'admin' ? new_admin_registration_path : new_user_registration_path           
        end

        def edit_registration_path(role) 
          role == 'admin' ? edit_admin_registration_path : edit_user_registration_path   
        end
    end      
  end
end