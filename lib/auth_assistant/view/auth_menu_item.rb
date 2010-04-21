module AuthAssistant
  module ViewHelpers
    module AuthMenuItem
      def sign_out_menu_item
        "<li>#{sign_out_link}</li>".html_safe if current_user
      end

      def edit_registration_menu_item
        "<li>#{edit_registration_link}</li>".html_safe if current_user
      end

      def sign_in_menu_item
        "<li>#{sign_in_link}</li>".html_safe if !current_user
      end

      def sign_up_menu_item
        "<li>#{sign_up_link}</li>".html_safe if !current_user
      end

      alias_method :logout_menu_item, :sign_out_menu_item
      alias_method :login_menu_item, :sign_in_menu_item  
      alias_method :register_menu_item, :sign_up_menu_item    
      alias_method :edit_profile_menu_item, :edit_registration_menu_item      
    end  
  end
end