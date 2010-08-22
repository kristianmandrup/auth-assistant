require 'spec_helper'

Minimal::Application.initialize!

describe "Rails extension" do
  describe 'View extension' do
    it "should extend Action View with Roles helper instance_methods" do

      # generalize this pattern in the RSpec 2 matcher!
      Rails3::PluginExtender.new do      
        extend_rails(:view) do
          after :initialize do
            :view.should be_extended_with AuthAssistant::View, :roles, :area
          end
        end
      end
    end    
  end
end