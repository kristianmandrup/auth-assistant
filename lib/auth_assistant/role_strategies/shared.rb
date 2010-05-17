module AuthAssistant    
  module RoleStrategy
    module Shared
      attr_accessor :ability
      
      def admin?
        role? 'admin'
      end

      def has(ability)
        @ability ||= ability
      end

      def owns(clazz)
        return if !ability
        base ||= RolePermit::Base.new(ability)
        base.owns(self, clazz)
      end
      
      def available_roles
        AuthAssistant::Model.available_roles
      end
    end
  end
end
