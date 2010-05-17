module AuthAssistant          
  module RoleStrategy
    module AdminField
            
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
        admin == true ? 'admin' : 'default' 
      end

      def role?(_role)
        role == _role.to_s
      end  

      module ClassMethods
        def set_scope
          scope :with_role, lambda { |role| {:conditions => ["role == ?", role]} }
        end
      end
      
      def self.included(base)  
        base.extend(ClassMethods)
      end          
    end
  end
end