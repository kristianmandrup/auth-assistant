module RolePermit

  class Base 
    attr_accessor :ability
       
    def initialize(ability)
      @ability = ability
    end

    def permit?(user) 
      puts "Base Permit"
    end
  end
  
  class Admin < Base
    def initialize(ability)
      super
    end

    def permit?(user)    
      super
      puts "Admin"
    end  
  end

  class User < Base
    def initialize(ability)
      super
    end

    def permit?(user) 
      super
      puts "User"
    end  
  end
end  


RolePermit::Admin.new(0).permit? 0
RolePermit::User.new(0).permit? 0