module DeviseAssistant 
  module Helpers
    module Roles
      def roles_area(clazz, *user_roles, &block)
        roles user_roles do
          content = with_output_buffer(&block)
          content_tag :div, content, :class => clazz    
        end
      end  
  
      def roles(*user_roles, &block)
        with_output_buffer(&block) if has_role?(user_roles)
      end 
    
      def role?(*user_roles)
        devise_role?(user_roles) || cancan_role?(user_roles)
      end
    
      protected
        def devise_role?(user_roles)        
          user_roles.flatten.any?{|role| warden.authenticate?(:scope => role.to_sym)}
        end

        def cancan_role?(user_roles)                
          union = current_user.roles & user_roles
          !union.empty?
        end                
    end
  end
end
