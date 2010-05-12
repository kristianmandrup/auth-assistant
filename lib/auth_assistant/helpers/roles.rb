module AuthAssistant 
  module Helpers
    module Roles
      def roles_area(clazz, *user_roles, &block)
        roles_block user_roles do             
          do_roles_area(clazz, &block)
        end
      end  

      def not_roles_area(clazz, *user_roles, &block)
        not_roles_block user_roles do             
          do_roles_area(clazz, &block)
        end
      end  
  
      def roles_block(*user_roles, &block)
        with_output_buffer(&block) if role?(user_roles)
      end 

      def not_roles_block(*user_roles, &block)
        with_output_buffer(&block) if !role?(user_roles)
      end 
    
      def role?(*user_roles)
        devise_role?(user_roles) || cancan_role?(user_roles)
      end
    
      protected
        def do_roles_area(clazz, &block)
          content = with_output_buffer(&block)
          content_tag :div, content, :class => clazz    
        end
      
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
