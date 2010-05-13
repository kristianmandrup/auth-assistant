module AuthAssistant
  def self.configure(&block)
    block.arity < 1 ? AuthAssistant::Model.class_eval(&block) : block.call(AuthAssistant::Model)   
  end
  
  module Model  
    class << self
      attr_accessor :role_strategy
      attr_accessor :available_roles
    
      def available_strategies
        [:admin_field, :role_field, :roles_field, :roles_mask, :role_assignment]
      end              
      
      def strategy(name)
        n = name.to_s
        available_strategies.include?(n.to_sym) ? n.to_sym.inspect : ':roles_field'
      end
    
      def role_strategy=(strategy)  
        raise UnknowStrategy, "unknown strategy: #{strategy.inspect}, must be one of: #{available_strategies.inspect}" if !available_strategies.include? strategy.to_sym      
        @strategy = strategy.to_sym
        constant = @strategy.camelize.constantize 
        User.extend RoleStrategy::Shared
        User.extend("RoleStrategy::#{constant}".constantize)
      end
    end
  end
end

