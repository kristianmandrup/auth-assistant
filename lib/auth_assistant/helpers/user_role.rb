module AuthAssistant
  module Helpers
    module UserRole
      def user_area(&block)
        user_block do
          do_user_area(&block)
        end
      end  

      def not_user_area(&block)
        not_user_block do
          do_user_area(&block)
        end
      end  

      def user_block(&block)
        with_output_buffer(&block) if user? 
      end  

      def not_user_block(&block)
        with_output_buffer(&block) if !user? 
      end  

      def user?
        devise_user? || cancan_user?
      end
        
      def self.included(base)
        base.helper_method :user_block, :not_user_block, :user_area, :not_user_area, :user? 
      end         
    
      protected
        def do_user_area(&block)
          content = with_output_buffer(&block)
          content_tag :div, content, :class => 'user'    
        end

        def devise_user?        
          user_signed_in? if respond_to? :user_signed_in?
        end

        def cancan_user?
          !current_user.admin?
        end    
    end
  end
end