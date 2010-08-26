module AuthAssistant::Helper
  module Role
    # does the user have ANY of the given roles?
    # Uses generic roles API    
    def has_role?(*roles)
      current_user.has_role? roles.flatten
    end

    # does the user have ALL of the given roles?
    # Uses generic roles API
    def has_roles?(*roles)
      current_user.has_roles? roles.flatten
    end

    # returns true if the current user owns the object
    # tries default 'owner' relations if none given as an argument
    def owner?(obj, relation=nil)
      if relation     
        return true if user_relation?(obj, relation)
      end                                
      [:user, :owner, :author].each do |relation|        
        return true if user_relation?(obj, relation)
      end
      false
    end    

    protected
    
    def user_relation? obj, relation
      raise ArgumentError, "User method must be a Symbol or String" if !relation.kind_of_label?
      current_user == obj.send(relation) if obj.respond_to? relation
    end
  end    
end
