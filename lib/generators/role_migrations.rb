require 'generators/migration_helper'

module AuthAssist
  module RoleMigrations

    def self.clazz(name)
      "AuthAssist::RoleMigrations::#{name.camelize}".constantize      
    end

    class Base 
      include ::AuthAssist::MigrationHelper

      attr_accessor :generator

      def initialize(generator)
        @generator = generator
      end
                        
      def generate_reverse_migration(strategy_name)
        reverse_migration(migration_names.first)        
      end   
      
      def setup
        run_migration if respond_to? :run_migration
        configure if respond_to? :configure
      end   
      
      def migration(options)
        generator.migration options
      end       
      
      def insert_user_relation(has_roles)
        generator.insert_user_relation has_roles        
      end
    end

    class AdminField < Base
      def migration_names
        ['add_admin_field_to_user']
      end

      def run_migration
        migration "#{admin_field_migration_name} admin:boolean"
      end
    end


    class RolesMask < Base
      def migration_names
        ['add_roles_mask_to_user']      
      end        

      def run_migration
        migration "#{roles_mask_migration_name} roles_mask:integer"
      end              
    end

       
    class RolesField < Base
      def migration_names
        ['add_roles_field_to_user']      
      end

      def run_migration
        migration "#{roles_field_migration_name} roles:string"
      end
            
    end

       
    class RoleField < Base
      def migration_names      
        ['add_role_field_to_user']      
      end

      def run_migration
        migration "#{role_field_migration_name} role:string"
      end      
    end


    class RoleAssignment < Base
      def migration_names
        ['add_role_id_to_user', 'create_roles']
      end

      def run_migration
        migration 'add_role_id_to_user role_id:integer'
        migration 'create_roles name:string'
      end

      def configure
        generate_role_model
        insert_user_relation(has_roles)
      end        
      
      def reverse_migration      
        migration_template 'remove_role_assignments_migration.rb', 'remove_role_assignments'
      end                
    end

    class MultiRoleAssignment < Base
      def migration_names
        ['add_role_assignment_id_to_user', 'create_role_assignments', 'create_roles']
      end

      def run_migration        
        migration 'add_role_assignment_id_to_user role_assignment_id:integer'
        migration 'create_role_assignments role_id:integer user_id:integer'      
        migration 'create_roles name:string'
      end

      def configure      
        insert_user_relation(has_role_assignments)
        insert_user_relation(has_roles_through_assignments)

        generate_role_model
        generate_role_assignment_model      
      end
      
      def reverse_migration      
        migration_template 'remove_multi_role_assignments_migration.rb', 'remove_multi_role_assignments'
      end                
      
    end
  end
end