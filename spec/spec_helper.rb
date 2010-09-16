require 'rspec/core'
require 'auth-assistant'
require 'rspec-action_view'

RSpec.configure do |config|
  config.mock_with :mocha 
  config.before do
    Dir.chdir Rails.root.path + '/../' do
      FileUtils.rm_rf "rails_app"
      %x[rails new rails_app --force]
    end
  end

  config.after do
    FileUtils.rm_rf Rails.root
  end
  
end

