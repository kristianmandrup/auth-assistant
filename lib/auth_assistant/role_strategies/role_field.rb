module AuthAssistant          
  module RoleStrategy
    module RoleField
      
      def roles=(*roles)
        new_role = roles.first.to_s
        self.role = new_role if CanCan.available_roles.include? new_role
      end

      def roles
        [role]
      end

      def role?(_role)
        roles.include? _role
      end  

      module ClassMethods
        def set_scope
          scope :with_role, lambda { |role| {:conditions => "role?(#{role})"} }
        end
      end
      
      def self.included(base)  
        base.extend(ClassMethods)
      end

    end
  end
end
