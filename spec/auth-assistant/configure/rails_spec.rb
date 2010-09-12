require 'spec_helper'

require 'active_support'
require 'action_controller'
require 'action_view'
# require 'active_record'
# require 'action_mailer'
require 'active_support/railtie'
# require 'rails/all'

module Minimal
  class Application < Rails::Application
    config.active_support.deprecation = :log
  end
end

Rails.application = Minimal::Application

Minimal::Application.initialize!

describe "Rails extension" do
  describe 'View extension' do
    it "should extend Action View with Roles helper instance_methods" do
      extend Rails3::PluginExtender::Macro
  
      after_init :view do |view|
        view.should be_extended_with AuthAssistant::View, :roles, :area, :user_action_menu
      end

      Minimal::Application.initialize!
    end    
  end
end