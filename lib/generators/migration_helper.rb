require 'rails/generators/migration'

module AuthAssist
  module MigrationHelper
    include Rails::Generators::Migration

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
      generate_role_model
      insert_user_relation('has_many :roles')
    end            

    def multi_role_assignment_migration
      generate_role_model
      generate_role_assignment_model
      
      insert_user_relation('has_many :role_assignments')
      insert_user_relation('has_many :roles, :through => :role_assignments')
    end            


    protected
    
      def model_exists?(name)
        File.exists?(File.join(Rails.root, "app/models/#{name}.rb"))
      end

      def generate_role_model
        return if model_exists?('role')
        run 'rails g model role name:string'
        write_model_file('role', role_file_content)      
      end

      def generate_role_assignment_model
        return if model_exists?('role_assignment')
        run 'rails g model role_assigment user_id:integer role_id:integer'          
        write_model_file('role_assignment', role_assignment_file_content)      
      end
    
      def model_file(name)                          
        File.join(Rails.root, "app/models/#{name}.rb")        
      end

      def write_model_file(name, content)
        File.open(model_file(name), 'w+') do |f| 
          f.write(content) 
        end
      end

      def insert_user_relation(relation)
        file = File.new(model_file('user'))
        return if (file.read =~ /#{relation}/) 
        gsub_file model_file('user'), /class User < ActiveRecord::Base/ do |match|
          match << "\n  #{relation}"
        end
      end      
          
      def role_file_content
        %q{
          class Role < ActiveRecord::Base
            has_many :role_assignments
            has_many :users, :through => :role_assignments
          end          
        }    
      end       
      
      def role_assignment_file_content
        %q{
          class RoleAssignment < ActiveRecord::Base
            belongs_to :user
            belongs_to :role
          end          
        }
      end
    
  end
end
