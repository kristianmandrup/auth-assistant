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
        view.stubs(:auth_labels).returns(:new_registration => 'new registration')
        view.stubs(:user_reg_path).with(:new, :admin).returns 'new/reg/path'
        view.stubs(:link_to).with('new registration', 'new/reg/path').returns 'it works'        
        view.new_registration_link(:role => :admin).should == 'it works'
      end    
    end
  end
end

