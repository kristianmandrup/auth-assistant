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
require 'auth-assistant/cancan/fixtures/ability'
require_all File.dirname(__FILE__) + '/fixtures/permits'

require "spec_helper"

module AuthAssistant::Roles
  def self.available
    User.roles
  end
end

class User
  attr_accessor :id, :role

  def self.roles
    [:guest, :admin]
  end    

  def initialize id, role
    self.id = id
    self.role = role
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
  attr_accessor :owner
end

class Post
  attr_accessor :writer  
end

class Article
  attr_accessor :author
end


describe AuthAssistant::Ability do
  context "Guest user" do
    before :each do
      guest = User.new(1, :guest)
      @ability = AuthAssistant::Ability.new guest
    end

    # can :read, [Comment, Post]
    # can [:update, :destroy], [Comment]
    # can :create, Article

    it "should be able to :read Comment and Post but NOT Article" do
      @ability.can?(:read, Comment).should be_true
      @ability.can?(:read, Post).should be_true      
      @ability.can?(:read, Article).should be_false
    end

    it "should be not able to :update only Comment" do
      @ability.can?(:update, Comment).should be_true
      @ability.can?(:update, Post).should be_false
    end

    it "should be not able to :create Article" do
      @ability.can?(:create, Comment).should be_false
      @ability.can?(:create, Post).should be_false
      @ability.can?(:create, Article).should be_true
    end

    it "should be able to :destroy Comment" do
      @ability.can?(:destroy, Comment).should be_true
      @ability.can?(:destroy, Post).should be_false
    end
  end
  
  context "Admin user" do
    before do
      admin = User.new(2, :admin)
      @ability = AuthAssistant::Ability.new admin
    end
  # 
  #   # can :manage, :all    
  # 
    it "should be able to :read anything" do
      @ability.can?(:read, Comment).should be_true
      @ability.can?(:read, Post).should be_true      
    end
  
    it "should be not able to :update everything" do
      @ability.can?(:update, Comment).should be_true
      @ability.can?(:update, Post).should be_true
    end
  
    it "should be not able to :create everything" do
      @ability.can?(:create, Comment).should be_true
      @ability.can?(:create, Post).should be_true      
    end
  
    it "should be not able to :update everything" do
      @ability.can?(:destroy, Comment).should be_true
      @ability.can?(:destroy, Post).should be_true
    end
  end
      
end