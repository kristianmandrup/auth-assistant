module AuthAssistant          
  module RoleStrategy
    module AdminField
      scope :with_role, lambda { |role| {:conditions => ["role == ?", role]} }
      
      def roles=(*roles)
        new_role = roles.first.to_s
        self.admin = new_role == 'admin'
      end

      def roles
        [role]
      end

      def role=(role)
        self.roles = [role]
      end

      def role
        admin? ? 'admin' : 'default' 
      end

      def role?(role)
        self.role == role
      end            
    end
  end
end