module AuthAssistant::Helpers
  module Role
    # does the user have ANY of the given roles?
    def has_role?(*user_roles)
      union = current_user.roles & user_roles
      !union.empty?
    end

    # does the user have ALL of the given roles?
    def has_roles?(*user_roles)
      union = current_user.roles - user_roles
      union.empty?
    end

    def admin?
      has_role? :admin      
    end

    def guest?
      has_role? :guest      
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
      return current_user == obj.send relation if obj.repond_to? relation      
    end
  end    
end
