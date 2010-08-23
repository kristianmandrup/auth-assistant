module AuthAssistant::View
  module Roles
    # for users WITH the given roles create a div area
    # with optional class given in options hash and render block
    # within this div  
    def for_roles(*user_roles, &block)
      options = last_option(user_roles)
      
      not_for_roles(user_roles, &block) if options == false
      
      roles_block user_roles do
        clazz = options[:class] || 'special'          
        area(clazz, &block)
      end
    end   
    alias_method :for_role, :for_roles

    # for users WITHOUT the given roles create a div area
    # with optional class given in options hash and render block
    # within this div  
    def not_for_roles(*user_roles, &block)
      options = last_option(user_roles)
      not_roles_block user_roles do             
        clazz = options[:class] || 'special'
        area(clazz, &block)
      end
    end  
    alias_method :not_for_role, :not_for_roles

    # execute block if user DOES have any of the given roles
    def roles_block(*user_roles, &block) 
      user_roles = user_roles.flatten
      has_role?(user_roles) ? with_output_buffer(&block) : nil
    end 

    # execute block if user DOES NOT have any of the given roles
    def not_roles_block(*user_roles, &block)            
      user_roles = user_roles.flatten
      !has_role?(user_roles) ? with_output_buffer(&block) : nil
    end        
    
    def area(clazz, &block)
      content = with_output_buffer(&block)
      content_tag :div, content, :class => clazz    
    end    
  end
end