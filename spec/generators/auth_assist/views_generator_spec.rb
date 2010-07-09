require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Generator' do
  GeneratorSpec.with_generator do
    destination File.join(Rails.root)
    tests AuthAssist::Generators::ViewsGenerator
    setup :prepare_destination
    setup :copy_routes
  end

  def check_generated_views folder=nil
    GeneratorSpec.check do |c|
      if folder
        c.run_generator folder 
      else             
        c.run_generator
        folder = 'menu'
      end
      c.view  folder, '_admin_login_items.html.erb', %w{admin_block not_admin_block}
      c.view  folder, '_login_items.html.erb',       %w{user_block  not_user_block}
      c.view  folder, 'registration_items.html.erb', %w{user_block  not_user_block}
    end    
  end

  it "should create views in default scope 'menu' " 
    check_generated_views
  end
  
  it "should create views in explicit scope 'login' " 
    check_generated_views 'login'
  end  
end
