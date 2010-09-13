require 'generator_spec_helper'
require_generator :cream => :config

describe 'role strategy generator: admin_flag' do
  use_helpers :model, :controller, :permits
  
  before :each do              
    setup_generator 'roles_generator' do
      tests Cream::Generators::RolesGenerator
    end    
    remove_all_permits
    remove_locale :auth_assist
    
    remove_from controller_file(:application) do
          %{
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
}
    end
  end

  after :each do
    remove_all_permits
  end

  context 'Clean app' do    
  end
end