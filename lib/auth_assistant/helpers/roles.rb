module AuthAssistant 
  module Helpers
    module Roles
      def roles_area(*user_roles, options, &block)
        options ||= {}
        roles_block user_roles do             
          clazz = options[:class] || 'special'          
          do_roles_area(clazz, &block)
        end
      end  

      def not_roles_area(*user_roles, options, &block)
        options ||= {}        
        not_roles_block user_roles do             
          clazz = options[:class] || 'special'
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

      def self.included(base)
        base.helper_method :roles_block, :not_roles_block, :roles_area, :not_roles_area, :role? 
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
