module AuthAssistant          
  module RoleStrategy
    module MultiRoleAssignment

      def role?(role)
        return true if roles && roles.include?(role.to_s)
        false
      end      

      module ClassMethods
        def set_scope
          scope :with_role, lambda { |role| 
            joins(:roles, :role_assignments).
            where("role_assigments.user_id == id AND role_assigments.role_id == role.id AND roles.id == ?", role)            
          }
        end

        def set_relationships
          has_many :role_assignments
          has_many :roles, :through => :role_assignments
        end
      end
      
      def self.included(base)  
        base.extend(ClassMethods)
      end          
      
    end
  end
end




