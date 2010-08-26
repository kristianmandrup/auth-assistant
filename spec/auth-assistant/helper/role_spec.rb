require 'require_all'
require 'spec_helper'

require 'auth_assistant/helper/role'

describe AuthAssistant::Helper::Role do
  
  extend_view_with AuthAssistant::Helper::Role  
  
  describe '#has_role?' do
    context 'user has role :admin' do
      it "should make has_role? :admin be true" do
        user = stub()
        user.stubs(:has_role?).with([:admin]).returns true

        with_engine do |e, view|
          view.stubs(:current_user).returns user

          res = e.run_template do 
            %{<%= has_role?(:admin) %> }
          end
          res.should match /true/
        end    
      end

      it "should make has_role? :guest be false" do
        user = stub()
        user.stubs(:has_role?).with([:guest]).returns false

        with_engine do |e, view|
          view.stubs(:current_user).returns user
          res = e.run_template do 
            %{<%= has_role?(:guest) %> }
          end
          res.should match /false/
        end    
      end
    end
  end

  describe '#has_roles?' do
    context 'user has roles :admin and :guest' do
      it "should make has_roles? :admin, :guest be true" do
        user = stub()
        user.stubs(:has_roles?).with([:admin, :guest]).returns true

        with_engine do |e, view|
          view.stubs(:current_user).returns user
          res = e.run_template do 
            %{<%= has_roles?(:admin, :guest) %> }
          end
          res.should match /true/
        end    
      end

      it "should make has_role? :unknown, :guest be false" do
        user = stub()
        user.stubs(:has_roles?).with([:unknown, :guest]).returns false

        with_engine do |e, view|
          view.stubs(:current_user).returns user
          res = e.run_template do 
            %{<%= has_roles?(:unknown, :guest) %> }
          end
          res.should match /false/
        end    
      end
    end
  end
  
  describe '#owner?' do
    it "should return true that kristian is the owner of the post" do
      user = stub()
      user.stubs(:owner).with([:unknown, :guest]).returns false


      with_engine do |e, view|
        view.stubs(:current_user).returns user
        @post.stubs(:owner).returns user
        
        res = e.run_template_locals :post => @post do 
          %{<%= owner?(post) %> }
        end
        res.should match /true/
      end    
    end
  end  
end
