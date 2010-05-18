module AuthAssist
  module MigrationHelper
    module CodeRefactor 

      # erase      
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


      # insert
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

      
      # refactor code
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
end