require 'require_all'
require 'spec_helper'

require 'auth_assistant/link/rest'

class Post
end

describe AuthAssistant::Link::Rest do
  setup_action_view do
    tests AuthAssistant::Link::Rest
  end  
  
  describe '#index_link' do
    it "should create an index link" do
      with_action_view do |view|           
        label = 'index'
        path = 'post/index'        
        post = Post.new

        view.stubs(:auth_labels).returns(:index => label)

        view.stubs(:posts_path).returns path
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, path).returns 'it works'        

        view.index_link(post, label).should == 'it works'
      end                     
    end
  end
end

