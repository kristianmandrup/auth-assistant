require 'auth_assistant/role_strategies/all'

module AuthAssistant
  def self.configure(&block)
    block.arity < 1 ? AuthAssistant::Model.class_eval(&block) : block.call(AuthAssistant::Model)   
  end
  
  module Model  
    class << self
      attr_accessor :role_strategy
      attr_accessor :available_roles
    
      def available_strategies
        [:admin_field, :role_field, :roles_field, :roles_mask, :role_assignment, :multi_role_assignment]
      end              
      
      def strategy(name)
        n = name.to_s
        available_strategies.include?(n.to_sym) ? n.to_sym : :roles_field
      end
    
      def role_strategy=(strategy_name)  
        puts "Applying role strategy: #{strategy_name}"

        if !available_strategies.include? strategy_name.to_sym              
          raise UnknownStrategy, "unknown strategy: #{strategy_name.inspect}, must be one of: #{available_strategies.inspect}" 
        end
        @strategy = strategy(strategy_name)
        camel = @strategy.to_s.camelize
        User.class_eval do
          include AuthAssistant::RoleStrategy::Shared
          include "AuthAssistant::RoleStrategy::#{camel}".constantize
          set_scope if respond_to? :set_scope         
          set_relationships if respond_to? :set_relationships
        end
      end
    end
  end
end

