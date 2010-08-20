# This file is copied as part of the config generator execution. Edit this to your liking when it is in your Rails 3 app /lib folder.

module RolePermit

  class Base 
    attr_accessor :ability
       
    def initialize(ability)
      @ability = ability
    end

    def can(action, subject, conditions = nil, &block)
      ability.can(action, subject, conditions, &block)
    end
        
    def cannot(action, subject, conditions = nil, &block)
      ability.cannot(action, subject, conditions, &block)
    end
    
    def owns(user, clazz)
      can :manage, clazz do |comment|
        comment.try(:user) == user || comment.try(:owner) == user
      end                
    end 
    
    def permit?(user)    
      user.has ability      
    end
  end
  
  class Admin < Base
    def initialize(ability)
      super
    end

    def permit?(user)    
      super
      return if !user.role? :admin    
      can :manage, :all    
    end  
  end

  class User < Base
    def initialize(ability)
      super
    end

    def permit?(user) 
      super
      return if user.role? :admin
      can :read, :all           
      
      # user.owns(Comment)
      
      # a user can manage comments he/she created
      # can :manage, Comment do |comment|
      #   comment.try(:user) == user
      # end            
      
      # can :create, Comment
    end  
  end

  class Moderator < Base
    def initialize(ability)
      super
    end
    
    def permit?(user)
      super
      return if !user.role?(:moderator)
      can :read, :all      
      # owns(user, Comment)
    end  
  end


  class Author < Base
    def initialize(ability)
      super
    end
    
    def permit?(user)     
      super      
      return if !user.role? :author
      # can :create, Post

      # an author can manage posts he/she created      
      # can :update, Post do |post|
      #   post.try(:user) == user      
      # end
    end  
  end
end
