module AuthAssistant           
  module RoleStrategy
    module RolesField
      
      def roles=(*roles)        
        self.roles = roles.split(',').reject{|e| (e =~ /^\w+$/) == nil}
      end

      def roles
        roles.split(',')
      end
      
      def role?(role)
        roles.include? role.to_s
      end      

      module ClassMethods
        def set_scope
          scope :with_role, lambda { |role|  
            where("role?(#{role})")
          }
        end
      end
      
      def self.included(base)  
        base.extend(ClassMethods)
      end
      
    end
  end
end