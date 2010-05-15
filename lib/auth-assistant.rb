require 'auth_assistant/configure'    

module ApplicationHelper 
  def self.auth_assist_helpers
    include AuthAssistant::ViewHelpers
  end
end

module AuthAssistant
  module ViewHelpers
    include AuthAssistant::ViewHelpers::SessionLink
    include AuthAssistant::ViewHelpers::RegistrationLink
    include AuthAssistant::ViewHelpers::RestLink        
    include AuthAssistant::ViewHelpers::AuthMenuItem       
  end
end
