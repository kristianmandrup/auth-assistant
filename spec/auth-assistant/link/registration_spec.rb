require 'require_all'
require 'spec_helper'

require 'auth_assistant/link/registration'

describe AuthAssistant::Link::Registration do
  setup_action_view do
    tests AuthAssistant::Link::Registration
  end  
  
  describe '#new_registration_link' do
    it "should create a registration link" do
      with_action_view do |view|           
        label = 'new registration'
        path = 'new/reg/path'        
        view.stubs(:auth_labels).returns(:new_registration => label)
        view.stubs(:user_reg_path).with(:new, :admin).returns path 
        view.stubs(:link_to).with(label, path).returns 'it works'        
        view.new_registration_link(:role => :admin).should == 'it works'
      end    
    end
  end
end

