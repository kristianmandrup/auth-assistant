require 'rspec-action_view'
require 'require_all'
require 'spec_helper'

module AuthAssistant
  module View
  end
end

require 'auth_assistant/view/host_area'

describe AuthAssistant::View::Host do
  setup_action_view do
    tests AuthAssistant::View::Host
  end  
  
  describe '#for_localhost' do
    it "should display localhost guarded content for localhost browser agent" do
      with_action_view do |view|
        view.stubs(:localhost?).returns true
        view.for_localhost { 'hello' }.should match /hello/
      end    
    end

    it "should NOT display localhost guarded content for NON-localhost browser agent" do
      with_action_view do |view|
        view.stubs(:localhost?).returns false
        view.for_localhost { 'hello' }.should be_nil
      end    
    end
  end

  describe '#for_public' do
    it "should display public content for public browser agent" do
      with_action_view do |view|
        view.stubs(:publichost?).returns true
        view.for_public { 'hello' }.should match /hello/
      end    
    end

    it "should NOT display public guarded content for NON-public browser agent" do
      with_action_view do |view|
        view.stubs(:publichost?).returns false
        view.for_public { 'hello' }.should be_nil
      end    
    end
  end
end