module AuthAssistant           
  module RoleStrategy
    module RolesMask
      scope :with_role, lambda { |role| {:conditions => "roles_mask & #{calc_index(role.to_s)} > 0"} }

      def roles=(*roles)        
        self.roles_mask = (roles & available_roles).map { |r| calc_index(r) }.sum
      end

      def roles
        ROLES.reject { |r| ((roles_mask || 0) & calc_index(r)).zero? }
      end
      
      def role?(role)
        roles.include? role.to_s
      end      
      
      protected 
        def calc_index(r)
          2**available_roles.index(r)
        end
    end
  end
end