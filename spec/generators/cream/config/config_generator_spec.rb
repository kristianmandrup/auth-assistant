require 'generator_spec_helper'
require_generator :cream => :config

describe 'role strategy generator: admin_flag' do
  use_helpers :model, :controller, :permit, :files, :file  

  before do
    # Dir.chdir Rails.root.path + '/../' do
    #   FileUtils.rm_rf "rails_app"
    #   exec "rails new rails_app --force"
    # end
  end

  # after do
  #   FileUtils.rm_rf Rails.root
  # end
  
  before :each do              
    setup_generator 'roles_generator' do
      tests Cream::Generators::ConfigGenerator
    end    
    remove_all_permits
    remove_locale :auth_assist if locale_file? :auth_assist
    
    File.remove_from controller_file(:application) do
          %{
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
}
    end if controller_file? :application
  end

  after :each do
    remove_all_permits
  end

  describe "Configure Rails 3 app with Cream using default options" do
    before do    
      puts "Running generator"
      Dir.chdir Rails.root do
        logfile = File.expand_path File.dirname(__FILE__) + '/../../config_generator.log'
        puts "Logfile at: #{logfile}"
        @generator = with_generator do |g|
          logfile_arg = "--logfile #{logfile}"
          arguments = "--strategy admin_flag #{logfile_arg}".args 
          puts "arguments: #{arguments}"
          g.run_generator arguments
        end
      end
    end # before
      
    it "should generate a Devise User with only a :guest role using :role_string strategy" do
      @generator.should generate_model :user do |clazz|
        # clazz.should have_devise_options :defaults

        # clazz.should use_roles :generic
        # clazz.should include_module 'Roles::Generic'
        # clazz.should have_call :roles,          :args => ':guest'
        # clazz.should have_call :role_strategy,  :args => ":role_string"
      end
    end # it

    # it "should generate a Devise Admin user" do
    #   @generator.should generate_model :admin do |clazz|
    #     # clazz.should use_roles    :generic
    #     # clazz.should include_module 'Roles::Generic'
    #     clazz.should inherit_from :user
    #   end        
    # end # it
  end # desc
end # desc


