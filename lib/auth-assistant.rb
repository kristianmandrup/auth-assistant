require 'auth_assistant/configure'    

module AuthAssistant
  module ViewHelpers
    include AuthAssistant::ViewHelpers::AuthLink
    include AuthAssistant::ViewHelpers::RestLink        
    include AuthAssistant::ViewHelpers::AuthMenuItem       
  end
end
