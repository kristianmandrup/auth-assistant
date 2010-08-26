require 'require_all'
require 'spec_helper'

require 'auth_assistant/link/registration'

describe AuthAssistant::Link::Registration do

  extend_view_with AuthAssistant::Link::Registration
  
  describe '#new_registration_link' do
    it "should create a registration link" do
      with_engine do |e, view|
        label = 'new registration'
        path = 'new/reg/path'        
        view.stubs(:auth_labels).returns(:new_registration => label)
        view.stubs(:user_reg_path).with(:new, :admin).returns path 
        view.stubs(:link_to).with(label, path).returns 'it works'

        res = e.run_template do 
          %{<%= new_registration_link(:role => :admin) %> }
        end
        res.should match /it works/  
      end
    end
  end
end

