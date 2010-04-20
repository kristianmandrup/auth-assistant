module AuthAssistant          
  module RoleStrategy
    module RolesModel
      scope :with_role, lambda { |role| {:conditions => ["roles.id == roles_id AND roles_id == ?", role], :join => :roles} }

      def role?(role)
        roles.include? role.to_s
      end      
      
    end
  end
end




