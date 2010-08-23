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
        
    def owner?(obj, relation=nil)
      if relation     
        return true if user_relation?(obj, relation)
      end                                
      [:user, :owner, :author].each do |relation|        
        return true if user_relation?(obj, relation)
      end
    end    

    protected
    
    def user_relation? user, relation
      raise ArgumentError, "Relation must be a Symbol or String" if !relation.kind_of_label?
      current_user == obj.send(relation) if obj.repond_to?(relation)
    end
  end    
end
