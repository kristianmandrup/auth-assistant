require 'require_all'
require 'spec_helper'

require 'auth_assistant/helper/host'

describe AuthAssistant::Helper::Host do
  setup_action_view do
    tests AuthAssistant::Helper::Host
  end  
  
  describe '#localhost?' do
    it "should return true if request.host is 'localhost'" do
      request = stub()
      request.stubs(:host).returns 'localhost'        
      with_action_view do |view|      
        view.stubs(:request).returns request
        view.localhost?.should be_true
      end    
    end

    it "should return true if request.host is '127.0.0.1'" do
      request = stub()
      request.stubs(:host).returns '127.0.0.1'        
      with_action_view do |view|      
        view.stubs(:request).returns request
        view.localhost?.should be_true
      end    
    end
  end

  describe '#publichost?' do
    it "should return false if request.host is 'localhost'" do
      request = stub()
      request.stubs(:host).returns 'localhost'        
      with_action_view do |view|      
        view.stubs(:request).returns request
        view.publichost?.should be_false
      end    
    end

    it "should return true if request.host is '214.353.343.222'" do
      request = stub()
      request.stubs(:host).returns '214.353.343.222'        
      with_action_view do |view|      
        view.stubs(:request).returns request
        view.publichost?.should be_true
      end    
    end
  end
end
