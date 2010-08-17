require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe 'Generator' do
  GeneratorSpec.with_generator do |g, c|
    g.tests AuthAssist::Generators::ViewsGenerator
    c.setup
  end

  def check_generated_views folder=nil
    GeneratorSpec.with_generator do |g, check|
      if folder
        g.run_generator folder 
      else             
        g.run_generator
        folder = 'menu'
      end
      check.view folder, '_admin_login_items.html.erb', %w{admin_block not_admin_block}
      check.view folder, '_login_items.html.erb',       %w{user_block  not_user_block}
      check.view folder, 'registration_items.html.erb', %w{user_block  not_user_block}
    end    
  end

  it "should create views in default scope 'menu' " do
    check_generated_views
  end
  
  it "should create views in explicit scope 'login' " do
    check_generated_views 'login'
  end  
end
