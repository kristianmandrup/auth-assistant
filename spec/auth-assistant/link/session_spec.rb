require 'require_all'
require 'spec_helper'

require 'auth_assistant/link/session'

describe AuthAssistant::Link::Session do

  extend_view_with AuthAssistant::Link::Session
  
  describe '#sign_out_link' do
    it "should create a sign out link" do
      with_engine do |e, view|
        label = 'log out'
        path = 'admin/log/out'        
        view.stubs(:auth_labels).returns(:sign_out => label)
        view.stubs(:destroy_session_path).with(:admin).returns path
        view.stubs(:link_to).with(label, path).returns 'it works'        

        res = e.run_template do 
          %{<%= sign_out_link(:role => :admin) %> }
        end
        res.should match /it works/
      end                     
    end
  end
end

