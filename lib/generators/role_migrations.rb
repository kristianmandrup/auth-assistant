module AuthAssist
  module RoleMigrations
    def admin_field_migration
      migration 'add_admin_field_to_user admin:boolean'
    end

    def roles_mask_migration
      migration 'add_roles_mask_to_user roles_mask:integer'
    end        

    def roles_field_migration
      migration 'add_roles_field_to_user roles:string'
    end

    def role_assignment_migration
      generate_role_model
      insert_user_relation(has_roles)
    end            

    def multi_role_assignment_migration      
      insert_user_relation(has_role_assignments)
      insert_user_relation(has_roles_through_assignments)

      generate_role_model
      generate_role_assignment_model      
    end            

    def role_field_migration
      migration 'add_role_field_to_user role:string'
    end      
  end
end