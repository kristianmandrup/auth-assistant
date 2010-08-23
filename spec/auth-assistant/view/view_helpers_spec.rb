require 'rspec-action_view'
require 'require_all'
require 'spec_helper'

module AuthAssistant
  module View
  end
end

require 'auth_assistant/view/role_area'

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
    describe '#roles_block' do                    
      it "display an :admin only block" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true          
          view.roles_block(:admin) { 'hello' }.should match /hello/
        end      
      end
      
      it "should not display a :guest only block" do
        with_action_view do |view|      
          view.stubs(:has_role?).with([:guest]).returns false          
          view.roles_block(:guest) { 'hello' }.should be_nil
        end
      end
    end # desc

    describe '#not_roles_block' do              
      it "should not display a block not for :admin" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true
          view.not_roles_block(:admin) { 'hello' }.should be_nil
        end    
      end
    
      it "should display a div block not for :guest" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:guest]).returns false
          view.not_roles_block(:guest) { 'hello' }.should match /hello/
        end    
      end
    end # desc
  end  
end