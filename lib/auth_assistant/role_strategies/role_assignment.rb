module AuthAssistant          
  module RoleStrategy
    module RoleAssignment

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
          scope :with_role, lambda { |role| 
            joins(:roles).
            where("user.roles_id = roles.id AND roles.id == ?", role)
          }
        end

        def set_relationships
          has_many :roles
        end
      end
      
      def self.included(base)  
        base.extend(ClassMethods)
      end          
      
    end
  end
end




