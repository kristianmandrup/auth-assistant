require 'rspec'
require 'rspec/autorun' 
# require 'auth-assistant'
require 'require_all' 
require 'sugar-high/module'

require 'active_support/inflector'

RSpec.configure do |config|
  config.mock_with :mocha
end

require 'cancan'
require 'cancan/matchers'

require 'auth_assistant/permit/base_permit'
require_all File.dirname(__FILE__) + '/fixtures/permits'

require 'auth-assistant/cancan/fixtures/ability'

require "spec_helper"

module AuthAssistant::Roles
  def self.available
    User.roles
  end
end

class User
  attr_accessor :id, :role, :name

  def self.roles
    [:guest, :admin, :editor]
  end    

  def initialize id, role, name
    self.id = id    
    raise ArgumentError, "Role #{role} is not in list of available roles: #{self.class.roles}" if !self.class.roles.include? role
    self.role = role
    self.name = name
  end
  
  def has_role? role
    self.role == role
  end     
end

module AuthAssistant::Roles
  def self.available
    User.roles
  end
end

class Comment
  attr_accessor :user_id

  def initialize user_id
    self.user_id = user_id
  end
end

class Post
  attr_accessor :writer  

  def initialize user_id
    self.writer = user_id
  end
end

class Article
  attr_accessor :author
  
  def initialize name
    self.author = name
  end
end

# can :read, [Comment, Post]
# can [:update, :destroy], [Comment]
# can :create, Article


describe AuthAssistant::Ability do
  context "Editor user" do
    before :each do
      @editor = User.new(1, :editor, 'kristian')
      @ability = AuthAssistant::Ability.new @editor
      @comment  = Comment.new(1)
      @post     = Post.new(1)
      @article  = Article.new('kristian')      
    end
   
    it "should be able to :read Comment he owns, using default :user_id relation - foreign key to User.id" do
      # @ability.can :manage, Comment, :user_id => @editor.id
      @ability.should be_able_to(:read, Comment)
    end

    it "should be able to :read Post he owns, using :owner relation - foreign key to User.id" do
      # @ability.can :manage, Post, :writer => @editor.id                
      @ability.should be_able_to(:read, Post)
    end
    
    it "should be able to :read Article he owns, using :author relation - foreign key to User.name" do
      # @ability.can :read, Article, :author => @editor.name                  
      @ability.should be_able_to(:read, Article)
    end 
  end        
end