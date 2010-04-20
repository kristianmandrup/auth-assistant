module AuthAssistant          
  module RoleStrategy
    module RoleField
      scope :with_role, lambda { |role| {:conditions => "role?(#{role})"} }
      
      def roles=(*roles)
        new_role = roles.first.to_s
        self.role = new_role if CanCan.available_roles.include? new_role
      end

      def roles
        [role]
      end

    end
  end
end
