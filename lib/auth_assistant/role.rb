module AuthAssistant::Roles
  def self.available
    User.roles
  end
end