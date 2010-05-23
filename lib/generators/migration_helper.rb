require 'rails/generators/migration'
require 'generators/auth_code_refactor'

module AuthAssist
  module MigrationHelper
    include Rails::Generators::Migration

    module ClassMethods    
      def migration_lookup_at(dirname) #:nodoc:
        Dir.glob("#{dirname}/[0-9]*_*.rb")
      end

      def migration_exists?(dirname, file_name) #:nodoc:
        migration_lookup_at(dirname).grep(/\d+_#{file_name}.rb$/).first
      end

      def current_migration_number(dirname) #:nodoc:
        migration_lookup_at(dirname).collect do |file|
          File.basename(file).split("_").first.to_i
        end.max.to_i
      end

      def next_migration_number(dirname) #:nodoc:
        orm = Rails.configuration.generators.options[:rails][:orm]
        require "rails/generators/#{orm}"
        "#{orm.to_s.camelize}::Generators::Base".constantize.next_migration_number(dirname)
      rescue
        raise NotImplementedError
      end
    end         

    def self.included(base) #:nodoc: 
      puts "MigrationHelper included by #{base}"
      base.extend ClassMethods      
    end
       
   
    def migration(options)   
      # migration_template "migration.rb", "db/migrate/devise_create_#{table_name}"      
      run "rails g migration #{options}"
    end

    protected

      include CodeRefactor
    
      def model_exists?(name)
        File.exists?(File.join(Rails.root, "app/models/#{name}.rb"))
      end

      def remove_model(model_name)
        model_name = model_name.to_s.camelize
        file = File.join(Rails.root, "app/models/#{name}.rb")        
        FileUtils.rm file if file
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
  end
end

