require 'require_all'
require 'spec_helper'

require 'auth_assistant/helper/role'

describe AuthAssistant::Helper::Role do
  setup_action_view do
    tests AuthAssistant::Helper::Role
  end  
  
  describe '#has_role?' do
    context 'user has role :admin' do
      it "should make has_role? :admin be true" do
        user = stub()
        user.stubs(:has_role?).with([:admin]).returns true

        with_action_view do |view|      
          view.stubs(:current_user).returns user
          view.has_role?(:admin).should be_true
        end    
      end

      it "should make has_role? :guest be false" do
        user = stub()
        user.stubs(:has_role?).with([:guest]).returns false

        with_action_view do |view|      
          view.stubs(:current_user).returns user
          view.has_role?(:guest).should be_false
        end    
      end
    end
  end

  describe '#has_roles?' do
    context 'user has roles :admin and :guest' do
      it "should make has_roles? :admin, :guest be true" do
        user = stub()
        user.stubs(:has_roles?).with([:admin, :guest]).returns true

        with_action_view do |view|      
          view.stubs(:current_user).returns user
          view.has_roles?(:admin, :guest).should be_true
        end    
      end

      it "should make has_role? :unknown, :guest be false" do
        user = stub()
        user.stubs(:has_roles?).with([:unknown, :guest]).returns false

        with_action_view do |view|      
          view.stubs(:current_user).returns user
          view.has_roles?(:unknown, :guest).should be_false
        end    
      end
    end
  end
  
  # describe '#owner?' do
  # end  
end
