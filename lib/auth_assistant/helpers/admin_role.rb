puts "AdminRole loaded"

module AuthAssistant
  module Helpers
    module AdminRole
      def admin_block(&block)
        with_output_buffer(&block) if admin?
      end  

      def not_admin_block(&block)
        with_output_buffer(&block) if !admin?
      end  

      def admin_or_owner_block(obj, &block)
        if admin? || owner?(obj)
          with_output_buffer(&block)
        end 
      end  

      def admin?  
        devise_admin?(on) || cancan_admin?(on)
      end

      def admin_area(&block)
        admin_block do
          do_admin_area(&block)
        end
      end  

      def not_admin_area(&block)
        not_admin_block do
          do_admin_area(&block)
        end
      end  

      def self.included(base)
        base.helper_method :admin_block, :not_admin_block, :admin_area, :not_admin_area, :admin_or_owner_block, :admin? 
      end         
    
      protected
        def do_admin_area(&block)
          content = with_output_buffer(&block)      
          content_tag :div, content, :class => 'admin'    
        end
      
        def owner?(obj)
          current_user == obj.user if obj.repond_to? :user      
          current_user == obj.owner if obj.repond_to? :owner
        end      

        def devise_admin?        
          admin_signed_in? if respond_to? :admin_signed_in?
        end

        def cancan_admin?               
          current_user.admin?
        end
    
    end
  end
end    