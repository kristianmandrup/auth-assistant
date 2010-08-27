require 'generator_spec_helper'
require_generator :cream => :config

describe 'role strategy generator: admin_flag' do
  r3_assist.use_helpers :app, :model, :controller

  permits.use_helpers
  
  before :each do              
    setup_generator 'roles_generator' do
      tests Cream::Generators::RolesGenerator
    end    
    remove_permits  :all
    remove_locale   :auth_assist
    
    remove_content_from controller_file(:application) do
          %{
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
}
    end
  end

  after :each do
    remove_permits
  end

  context 'Clean app' do      
    describe "Configure Rails 3 app with Cream using default options" do
      before do        
        @generator = with_generator do |g|
          g.run_generator arguments.args
        end
        
        it "should generate a Devise User with only a :guest role using :role_string strategy"
          @generator.should generate_model :user do |clazz|
            clazz.should have_devise_options :defaults

            clazz.should use_roles :generic
            # clazz.should include_module 'Roles::Generic'
            clazz.should have_call :roles,          :args => ':guest'
            clazz.should have_call :role_strategy,  :args => ":role_string"
          end

        it "should generate a Devise Admin user"
          @generator.should generate_model :admin do |clazz|
            clazz.should use_roles    :generic
            # clazz.should include_module 'Roles::Generic'
            clazz.should inherit_from :user
          end        
        end
      end            
    end
  end

  describe "Configure Rails 3 app with Cream using options: --strategy many_roles --admin-user --orm AR" do      
    
    before do        
      @generator = with_generator do |g|   
        arguments = "--strategy many_roles --admin-user --orm AR"
        puts "arguments: #{arguments}"
        g.run_generator arguments.args
      end
      
      it "should generate a Devise User"
        @generator.should generate_model :user do |clazz|
          clazz.should have_devise_options :defaults

          # clazz.should include_module 'Roles::ActiveRecord'
          clazz.should use_roles :active_record
          clazz.should have_call :roles,          :args => ':admin, :guest'
          clazz.should have_call :role_strategy,  :args => ":many_roles"        
        end

      it "should generate a Devise Admin user"
        @generator.should generate_model :admin do |clazz|
          clazz.should include_module 'Roles::ActiveRecord'
          clazz.should inherit_from   :user
        end        
      end
    end # desc
  end # context  
end # desc


