module AuthAssistant           
  module RoleStrategy
    module RolesMask

      def roles=(*roles)        
        self.roles_mask = (roles & available_roles).map { |r| calc_index(r) }.sum
      end

      def roles
        ROLES.reject { |r| ((roles_mask || 0) & calc_index(r)).zero? }
      end
      
      def role?(role)
        roles.include? role.to_s
      end      

      module ClassMethods
        def set_scope
          scope :with_role, lambda { |role| 
            where("roles_mask & #{calc_index(role.to_s)} > 0") 
          }
        end
      end
      
      def self.included(base)  
        base.extend(ClassMethods)
      end
      
      protected 
        def calc_index(r)
          2**available_roles.index(r)
        end
    end
  end
end