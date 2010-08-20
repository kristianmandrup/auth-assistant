class Ability
  include CanCan::Ability

  def self.role_permits users
    @role_permits if @role_permits

    # use inject ?
    @role_permits ||= [] 
    AuthAssistant::Roles.available.each do |role|                         
      # set up each RolePermit instance to share this same Ability so that the can and cannot operations work on the same permission collection!
      @role_permits << Kernel.const_get("RolePermit::#{role}").new(self)
    end
    @role_permits
  end

  def initialize(user, request)
    # put ability logic here!
    user ||= User.new # guest    
    Ability.role_permits.each{|rp| rp.permit?(user, request) }
  end    
end
      
