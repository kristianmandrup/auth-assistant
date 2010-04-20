module AuthAssistant
  module Helpers
    module AdminRole
      def admin(on = true, &block)
        with_output_buffer(&block) if admin?(on)
      end  

      def admin_or_owner(obj, on = true, &block)
        if admin?(on) || current_user ==  obj.user
          with_output_buffer(&block)
        end 
      end  

      def admin?(on = true)  
        devise_admin?(on) || cancan_admin?(on)
      end

      def admin_area(&block)
        admin do
          content = with_output_buffer(&block)      
          content_tag :div, content, :class => 'admin'    
        end
      end  
    
      protected
        def devise_admin?(on)        
          admin_signed_in? && on || (!admin_signed_in? && !on) if respond_to? :admin_signed_in?
        end

        def cancan_admin?(on)                
          current_user.admin?
        end
    
    end
  end
end    