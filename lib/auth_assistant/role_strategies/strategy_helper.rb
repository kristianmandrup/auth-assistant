module AuthAssistant    
  module RoleStrategy
    module Helper
      def admin?
        role? 'admin'
      end
      
      def available_roles
        AuthAssistant::Model.available_roles
      end
    end
  end
end
