require 'rspec-action_view'
require 'require_all'
require 'spec_helper'

module AuthAssistant
  module View
  end
end

require 'auth_assistant/view/role_area'
require 'auth_assistant/view/host_area'

describe AuthAssistant::View::Roles do
  extend_view_with AuthAssistant::View, :roles, :host
  
  describe '#area' do
    it "should display the div with hello" do
      with_engine do |e, view|

        res = e.run_template do 
          %{<%= area :class => 'red' do %>
              hello
           <% end %>}
        end
        res.should match /<div class="red">/
        res.should match /hello/
      end
    end

    it "should display the div with hello when localhost block nested inside" do
      with_engine do |e, view|
        view.stubs(:localhost?).returns true
        
        res = e.run_template do 
          %{<%= area :class => 'red' do %>
              <%= for_localhost { 'hello' } %>
           <% end %>}
        end
        res.should match /<div class="red">/
        res.should match /hello/
      end
    end

    it "should display the div with hello when nested within localhost block" do
      with_engine do |e, view|
        view.stubs(:localhost?).returns true
        
        res = e.run_template do 
          %{<%= for_localhost do %>
              <%= area :class => 'red' do %>              
                hello
              <% end %>  
           <% end %>
          }
        end
        res.should match /<div class="red">/
        res.should match /hello/
      end
    end
  end

  context 'admin user' do  
    describe '#for_roles' do                    
      it "display an :admin only block" do        
        with_engine do |e, view|
          view.stubs(:has_role?).with([:admin]).returns true

          res = e.run_template do 
            %{<%= for_roles(:admin) { 'hello' } %>}
          end
          res.should match /hello/
        end
      end
      
      it "should not display a :guest only block" do
        with_engine do |e, view|
          view.stubs(:has_role?).with([:guest]).returns false

          res = e.run_template do 
            %{<%= for_roles(:guest) { 'hello' } %>}
          end        
          res.should be_empty
        end
      end
    end # desc  
  
    describe '#not_for_roles' do              
      it "should not display a block not for :admin" do        
        with_engine do |e, view|
          view.stubs(:has_role?).with([:admin]).returns true

          res = e.run_template do 
            %{<%= not_for_roles(:admin) { 'hello' } %>}
          end        
          res.should be_empty
        end
      end
    
      it "should display a div block not for :guest" do        
        with_engine do |e, view|
          view.stubs(:has_role?).with([:guest]).returns false

          res = e.run_template do 
            %{<%= not_for_roles(:guest) { 'hello' } %>}
          end        
          res.should match /hello/
        end
      end
    end # desc
  
    describe '#area_for_roles' do              
      it "should display an area for :admin" do        
        with_engine do |e, view|
          view.stubs(:has_role?).with([:admin]).returns true

          res = e.run_template do 
            %{<%= area_for_roles(:admin) { 'hello' } %>}
          end        
          res.should match /hello/
        end
      end
    
      it "should not display an area for user not :admin" do        
        with_engine do |e, view|
          view.stubs(:has_role?).with([:admin]).returns false

          res = e.run_template do 
            %{<%= area_for_roles(:admin) { 'hello' } %>}
          end        
          res.should be_empty
        end
      end
    end # desc
  # 
  #   describe '#area_not_for_roles' do              
  #     it "should not display an area for user :admin" do        
  #       with_action_view do |view|      
  #         view.stubs(:has_role?).with([:admin]).returns true
  #         view.area_not_for_roles(:admin) { 'hello' }.should be_nil
  #       end    
  #     end
  #   
  #     it "should display an area for user not :admin" do        
  #       with_action_view do |view|  
  #         # he is not admin    
  #         view.stubs(:has_role?).with([:admin]).returns false
  #         view.area_not_for_roles(:admin) { 'hello' }.should match /hello/
  #       end    
  #     end                
  #   end # desc             
  end # context
end