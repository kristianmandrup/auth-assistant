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
  
  describe '#create_link' do
    it "should create a create link" do
      with_action_view do |view|           
        label = 'create'
        path = 'post/create'        
        post = Post.new

        view.stubs(:auth_labels).returns(:index => label)

        view.stubs(:new_post_path).returns path
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, path).returns 'it works'        

        view.create_link(post, label).should == 'it works'
      end                     
    end
  end

  describe '#edit_link' do
    it "should create a create link" do
      with_action_view do |view|           
        label = 'create'
        path = 'post/create'        
        post = Post.new

        view.stubs(:auth_labels).returns(:index => label)

        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, [:edit, post]).returns 'it works'        

        view.edit_link(post, label).should == 'it works'
      end                     
    end
  end

  describe '#delete_link' do
    it "should create a delete link" do
      with_action_view do |view|           
        label = 'delete'
        path = 'post/delete'        
        post = Post.new

        view.stubs(:auth_labels).returns(:index => label)

        view.stubs(:can?).returns true
        view.stubs(:link_to).returns 'it works'        

        view.delete_link(post, label).should == 'it works'
      end                     
    end
  end

  
  describe '#show_link' do
    it "should create a show link" do
      with_action_view do |view|           
        label = 'show'
        path = 'post/show'        
        post = Post.new

        view.stubs(:auth_labels).returns(:index => label)
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, post).returns 'it works'        

        view.show_link(post, label).should == 'it works'
      end                     
    end
  end
end

