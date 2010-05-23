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
                        
      def generate_reverse_migration 
        return reverse_migration if respond_to? :reverse_migration
        generation.reverse_migration(migration_names.first)        
      end   
      
      def setup
        run_migration if respond_to? :run_migration
        configure if respond_to? :configure
      end   

      def migration_name
        migration_names[0]
      end

      def run_migration
        migration "#{migration_name} #{migration_field}"
      end

      def configure 
        # can be overridden if necessary by subclass method
      end

      def reverse_configure
        # can be overridden if necessary by subclass method
      end

      protected
        def migration(options)
          generator.migration options
        end       
      
        def insert_relation(model_name, relation)
          generator.insert_relation model_name, relation        
        end    

        def remove_relation(model_name, relation)
          generator.remove_relation(model_name, relation)
        end

        def remove_model model_name
          generator.remove_model model_name
        end
      
        def generate_role_model
          generator.generate_role_model        
        end
      
        def generate_role_assignment_model
          generator.generate_role_assignment_model
        end
        
        def migration_template(source, target)
          generator.migration_template source, target
        end                  
    end

    class AdminField < Base
      def migration_names
        ['add_admin_field_to_user']
      end
      
      def migration_field
        "admin:boolean"
      end
    end


    class RolesMask < Base
      def migration_names
        ['add_roles_mask_to_user']      
      end        

      def migration_field
        "roles_mask:integer"
      end
    end

       
    class RolesField < Base
      def migration_names
        ['add_roles_field_to_user']      
      end      

      def migration_field
        "roles:string"
      end            
    end

       
    class RoleField < Base
      def migration_names      
        ['add_role_field_to_user']      
      end

      def migration_field
        "role:string"
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
        insert_relation(:user, has_roles)
        insert_relation(:role, belongs_to_user)        
      end        

      def reverse_configure
        remove_model(:role)
        remove_relation(:user, has_roles)
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
        # migration 'add_role_assignment_id_to_user role_assignment_id:integer'
        migration 'create_role_assignments role_id:integer user_id:integer'      
        migration 'create_roles name:string'
      end

      def configure      
        insert_relation(:user, has_role_assignments)
        insert_relation(:user, has_roles_through_assignments)

        generate_role_model
        generate_role_assignment_model      
      end
      
      def reverse_configure
        remove_model :role
        remove_role_assignment_model

        remove_relation(:user, has_role_assignments)
        remove_relation(:user, has_roles_through_assignments)
      end        
           
      def reverse_migration      
        migration_template 'remove_multi_role_assignments_migration.rb', 'remove_multi_role_assignments'
      end                
      
    end
  end
end