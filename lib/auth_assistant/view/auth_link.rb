module AuthAssistant
  module ViewHelpers
    module AuthLink                                                        
      def sign_out_link(label = auth_labels[:sign_out])
        path = role == 'admin' ? destroy_admin_session_path : destroy_user_session_path
        link_to(label, path)
      end

      def sign_in_link(role, label = auth_labels[:sign_in])  
        link_to(label, new_admin_session_path)
      end

      def sign_up_link(role, label = auth_labels[:sign_up])   
        path = role == 'admin' ? new_admin_registration_path : new_user_registration_path   
        link_to(label, path)
      end

      def edit_registration_link(label = auth_labels[:edit_registration])  
        path = role == 'admin' ? edit_admin_registration_path : edit_user_registration_path   
        link_to(label, path)
      end

      alias_method :log_out_link, :sign_out_link
      alias_method :log_in_link, :sign_in_link  
      alias_method :register_link, :sign_up_link    
      alias_method :edit_profile_link, :edit_registration_link      
    end  
    
  end
end
