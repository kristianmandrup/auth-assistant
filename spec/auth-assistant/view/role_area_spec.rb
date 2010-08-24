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
    describe '#for_roles' do                    
      it "display an :admin only block" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true          
          view.for_roles(:admin) { 'hello' }.should match /hello/
        end      
      end
      
      it "should not display a :guest only block" do
        with_action_view do |view|      
          view.stubs(:has_role?).with([:guest]).returns false          
          view.for_roles(:guest) { 'hello' }.should be_nil
        end
      end
    end # desc

    describe '#not_for_roles' do              
      it "should not display a block not for :admin" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true
          view.not_for_roles(:admin) { 'hello' }.should be_nil
        end    
      end
    
      it "should display a div block not for :guest" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:guest]).returns false
          view.not_for_roles(:guest) { 'hello' }.should match /hello/
        end    
      end                
    end # desc

    describe '#area_for_roles' do              
      it "should display an area for :admin" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true
          view.area_for_roles(:admin) { 'hello' }.should match /hello/
        end    
      end
    
      it "should not display an area for user not :admin" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns false
          view.area_for_roles(:admin) { 'hello' }.should be_nil
        end    
      end                
    end # desc

    describe '#area_not_for_roles' do              
      it "should not display an area for user :admin" do        
        with_action_view do |view|      
          view.stubs(:has_role?).with([:admin]).returns true
          view.area_not_for_roles(:admin) { 'hello' }.should be_nil
        end    
      end
    
      it "should display an area for user not :admin" do        
        with_action_view do |view|  
          # he is not admin    
          view.stubs(:has_role?).with([:admin]).returns false
          view.area_not_for_roles(:admin) { 'hello' }.should match /hello/
        end    
      end                
    end # desc
            
  end  
end