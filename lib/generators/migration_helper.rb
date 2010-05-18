require 'rails/generators/migration'

module AuthAssist
  module MigrationHelper
    include Rails::Generators::Migration

    module ClassMethods    
      def migration_lookup_at(dirname) #:nodoc:
        puts "migration_lookup_at: #{dirname}"
        Dir.glob("#{dirname}/[0-9]*_*.rb")
      end

      def migration_exists?(dirname, file_name) #:nodoc:
        puts "migration_exists?: #{dirname}, #{file_name}"
        migration_lookup_at(dirname).grep(/\d+_#{file_name}.rb$/).first
      end

      def current_migration_number(dirname) #:nodoc:
        puts "current_migration_number: #{dirname}"
        migration_lookup_at(dirname).collect do |file|
          File.basename(file).split("_").first.to_i
        end.max.to_i
      end

      def next_migration_number(dirname) #:nodoc:
        puts "next_migration_number: #{dirname}"
        orm = Rails.configuration.generators.options[:rails][:orm]
        require "rails/generators/#{orm}"
        "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
      rescue
        raise NotImplementedError
      end
    end         

    def self.included(base) #:nodoc:
      base.extend ClassMethods      
    end
       
   
    def migration(options)   
      # migration_template "migration.rb", "db/migrate/devise_create_#{table_name}"      
      run "rails g migration #{options}"
    end

    protected

      def clear_user_relations
        erase_in_user(has_roles_through_assignments)
        erase_in_user(has_roles)  
        erase_in_user(has_role_assignments)
      end

      def erase_in_user(txt)  
        file = File.new(model_file('user'))
        return if !(file.read =~ /#{txt}/)         
        gsub_file model_file('user'), /#{Regexp.escape(txt + "\n")}/, ''
      end
    
      def model_exists?(name)
        File.exists?(File.join(Rails.root, "app/models/#{name}.rb"))
      end

      def generate_role_model
        return if model_exists?('role')
        run 'rails g model Role name:string'
        write_model_file('role', role_file_content)      
      end

      def generate_role_assignment_model
        run 'rails g model RoleAssignment user_id:integer role_id:integer'          
        return if model_exists?('role_assignment')
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

      def has_role_assignments 
        'has_many :role_assignments'
      end

      def has_roles_through_assignments 
        'has_many :roles, :through => :role_assignments'
      end

      def has_roles 
        'has_many :roles'
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

