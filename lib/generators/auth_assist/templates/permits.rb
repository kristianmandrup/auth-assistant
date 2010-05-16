module RolePermit
  class Admin
    def initialize
    end
  
    def permit?(user)
      return if !user.role? :admin    
      can :manage, :all    
    end  
  end

  class User
    def initialize
    end

    def permit?(user)
      return if user.role? :admin
      can :read, :all     
      # a user can manage comments he/she created
      # can :manage, Comment do |comment|
      #   comment.try(:user) == user
      # end            
      # can :create, Comment
    end  
  end

  class Moderator
    def initialize
    end

    def permit?(user)
      return if !user.role?(:moderator)
      can :read, :all
      # can :manage, Comment
    end  
  end


  class Author
    def initialize
    end
  
    def permit?(user)     
      return if !user.role? :author
      # can :create, Post

      # an author can manage posts he/she created      
      # can :update, Post do |post|
      #   post.try(:user) == user      
      # end
    end  
  end
end
