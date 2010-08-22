module AuthAssistant::View
  module Roles
    # for users WITH the given roles create a div area
    # with optional class given in options hash and render block
    # within this div  
    def for_roles(*user_roles, options, &block)
      options ||= {}
      not_for_roles(user_roles, &block) if options == false
      
      roles_block user_roles do
        clazz = options[:class] || 'special'          
        roles_area(clazz, &block)
      end
    end   
    alias_method :for_role, :for_roles

    # for users WITHOUT the given roles create a div area
    # with optional class given in options hash and render block
    # within this div  
    def not_for_roles(*user_roles, options, &block)
      options ||= {}
      not_roles_block user_roles do             
        clazz = options[:class] || 'special'
        for_area(clazz, &block)
      end
    end  
    alias_method :not_for_role, :not_for_roles

    # execute block if user DOES have any of the given roles
    def roles_block(*user_roles, &block)
      with_output_buffer(&block) if role?(user_roles)
    end 

    # execute block if user DOES NOT have any of the given roles
    def not_roles_block(*user_roles, &block)
      with_output_buffer(&block) if !has_role?(user_roles)
    end        
  end
end