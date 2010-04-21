module AuthAssistant          
  module RoleStrategy
    module RoleAssignment
      scope :with_role, lambda { |role| {:conditions => ["role_assigment.user_id == id AND role_assigment.role_id = role.id AND role.id == ?", role], :join => :role, :role_assignment} }

      has_many :role_assignments
      has_many :roles, :through => :role_assignments

      def role?(role)
        roles.include? role.to_s
      end      
      
    end
  end
end




