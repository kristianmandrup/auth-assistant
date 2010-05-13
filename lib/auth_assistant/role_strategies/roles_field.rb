module AuthAssistant           
  module RoleStrategy
    module RolesField
      scope :with_role, lambda { |role| {:conditions => "role?(#{role})"} }

      def roles=(*roles)        
        self.roles = roles.split(',').reject{|e| (e =~ /^\w+$/) == nil}
      end

      def roles
        roles.split(',')
      end
      
      def role?(role)
        roles.include? role.to_s
      end      
      
    end
  end
end