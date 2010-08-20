module AuthAssistant::Role
  def self.available
    User.roles
  end
end