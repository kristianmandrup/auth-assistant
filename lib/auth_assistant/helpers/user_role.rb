module AuthAssistant
  module Helpers
    module UserRole
      def user_area(&block)
        user do
          content = with_output_buffer(&block)
          content_tag :div, content, :class => 'user'    
        end
      end  

      def user(on = true, &block)
        with_output_buffer(&block) if user?(on) 
      end  

      def user?(on = true)
        devise_user?(on) || cancan_user?(on)
      end
    
      protected
        def devise_user?(on)        
          admin_signed_in? && on || (!admin_signed_in? && !on) if respond_to? :admin_signed_in?
        end

        def cancan_user?(on)                
          !current_user.admin?
        end    
    end
  end
end