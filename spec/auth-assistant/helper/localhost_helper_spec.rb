require 'require_all'
require 'spec_helper'

module AuthAssistant
  module View
  end
end

require 'auth_assistant/helper/local_host'

describe AuthAssistant::View::Roles do
  setup_action_view do
    tests AuthAssistant::View::Roles       
  end  
  
  describe '#area' do
    it "display a div with content" do        
      with_action_view do |view|      
        view.area(:my_class) { 'hello' }.should match /hello/
      end    
    end
  end

  context 'admin user' do  
    describe '#for_roles' do                    
      it "display an :admin only block" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true          
          view.for_roles(:admin) { 'hello' }.should match /hello/
        end      
      end