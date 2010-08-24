module AuthAssistant::View
  module Roles
    # for users WITH the given roles create a div area
    # with optional class given in options hash and render block
    # within this div  
    def area_for_roles(*user_roles, &block)
      options = last_option(user_roles)
      
      not_for_roles(user_roles, &block) if options == false
      
      for_roles user_roles do
        clazz = options[:class] || 'special'          
        area(clazz, &block)
      end
    end   
    alias_method :area_for_role, :area_for_roles

    # for users WITHOUT the given roles create a div area
    # with optional class given in options hash and render block
    # within this div  
    def area_not_for_roles(*user_roles, &block)
      options = last_option(user_roles)
      not_for_roles user_roles do             
        clazz = options[:class] || 'special'
        area(clazz, &block)
      end
    end  
    alias_method :area_not_for_role, :area_not_for_roles

    # execute block if user DOES have any of the given roles
    def for_roles(*user_roles, &block) 
      user_roles = user_roles.flatten
      has_role?(user_roles) ? with_output_buffer(&block) : nil
    end 
    alias_method :for_role, :for_roles

    # execute block if user DOES NOT have any of the given roles
    def not_for_roles(*user_roles, &block)            
      user_roles = user_roles.flatten
      !has_role?(user_roles) ? with_output_buffer(&block) : nil
    end        
    alias_method :not_for_role, :not_for_roles
    
    def area(clazz, &block)
      content = with_output_buffer(&block)
      content_tag :div, content, :class => clazz    
    end    
  end
end