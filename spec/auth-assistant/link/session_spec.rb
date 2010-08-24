require 'require_all'
require 'spec_helper'

require 'auth_assistant/link/session'

describe AuthAssistant::Link::Session do
  setup_action_view do
    tests AuthAssistant::Link::Session
  end  
  
  describe '#sign_out_link' do
    it "should create a sign out link" do
      with_action_view do |view|      
        label = 'log out'
        path = 'admin/log/out'        
        view.stubs(:auth_labels).returns(:sign_out => label)
        view.stubs(:destroy_session_path).with(:admin).returns path
        view.stubs(:link_to).with(label, path).returns 'it works'        
        view.sign_out_link(:role => :admin).should == 'it works'
      end    
    end
  end
end

