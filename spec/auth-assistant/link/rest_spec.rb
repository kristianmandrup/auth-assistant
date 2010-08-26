require 'require_all'
require 'spec_helper'

require 'auth_assistant/link/rest'

class Post
end

describe AuthAssistant::Link::Rest do

  extend_view_with AuthAssistant::Link::Rest
  
  describe '#index_link' do
    it "should create an index link" do
      with_engine do |e, view|
        label = 'index'
        path = 'post/index'        
        post = Post.new

        view.stubs(:auth_labels).returns(:index => label)

        view.stubs(:posts_path).returns path
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, path).returns 'it works'        

        res = e.run_template_locals :post => post, :name => label do 
          %{<%= index_link(post, name) %> }
        end 
        res.should match /it works/
      end                     
    end
  end
  
  describe '#create_link' do
    it "should create a create link" do
      with_engine do |e, view|
        label = 'create'
        path = 'post/create'        
        post = Post.new
  
        view.stubs(:auth_labels).returns(:index => label)
  
        view.stubs(:new_post_path).returns path
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, path).returns 'it works'        
  
        res = e.run_template_locals :post => post, :name => label do 
          %{<%= create_link(post, name) %> }
        end
        res.should match /it works/
      end                     
    end
  end
  
  describe '#edit_link' do
    it "should create a create link" do
      with_engine do |e, view|
        label = 'create'
        path = 'post/create'        
        post = Post.new
  
        view.stubs(:auth_labels).returns(:index => label)
  
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, [:edit, post]).returns 'it works'        
  
        res = e.run_template_locals :post => post, :name => label do 
          %{<%= edit_link(post, name) %> }
        end
        res.should match /it works/
      end                     
    end
  end
  
  describe '#delete_link' do
    it "should create a delete link" do
      with_engine do |e, view|
        label = 'delete'
        path = 'post/delete'        
        post = Post.new
  
        view.stubs(:auth_labels).returns(:index => label)
  
        view.stubs(:can?).returns true
        view.stubs(:link_to).returns 'it works'        
  
        res = e.run_template_locals :post => post, :name => label do 
          %{<%= delete_link(post, name) %> }
        end
        res.should match /it works/
      end                     
    end
  end
  
  
  describe '#show_link' do
    it "should create a show link" do
      with_engine do |e, view|
        label = 'show'
        path = 'post/show'        
        post = Post.new
  
        view.stubs(:auth_labels).returns(:index => label)
        view.stubs(:can?).returns true
        view.stubs(:link_to).with(label, post).returns 'it works'        

        res = e.run_template_locals :post => post, :name => label do 
          %{<%= show_link(post, name) %> }
        end
        res.should match /it works/
      end                     
    end
  end
end

