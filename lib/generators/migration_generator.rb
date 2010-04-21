module AuthAssistant
  module MigrationHelper
    # DRY up!
    def clear_migration_role_field                
      say 'Generating clear migration for RoleField'
    end  
    
    def admin_field_migration
      migration 'add_admin_field_to_user admin:boolean'
    end

    def role_field_migration
      migration 'add_role_field_to_user role:string'
    end

    def role_masks_migration
      migration 'add_role_masks_to_user role_masks:integer'
    end        

    def roles_field_migration
      migration 'add_roles_field_to_user roles:string'
    end

    def role_assignment_migration
      migration 'create_roles name:string'
      migration 'create_role_assigments user_id:integer role_id:integer'          
    end            
    
  end
end
      