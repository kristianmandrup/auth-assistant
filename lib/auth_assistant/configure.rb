require 'auth_assistant/helpers/all'
require 'auth_assistant/model/user_config'
# require 'auth_assistant/role_strategies/all'
require 'auth_assistant/translate/authlabels'  
require 'auth_assistant/view/all'  

module AuthAssistant
  
  # This module is automatically included methods into all controllers.
  # It also makes some methods available to all views.
  module ControllerAdditions
    def self.helpers
      ['AdminRole', 'UserRole', 'Roles', 'LocalHost', 'AuthLabel']
    end

    def self.view_helpers
      ['AuthLink', 'RestLink', 'AuthMenuItem']
    end
  end
end



if defined? ActionController
  ActionController::Base.class_eval do 
    include AuthAssistant::Helpers::AdminRole
    include AuthAssistant::Helpers::UserRole
    include AuthAssistant::Helpers::Roles
    include AuthAssistant::Helpers::LocalHost
    include AuthAssistant::Helpers::AuthLabel
    
    include AuthAssistant::ViewHelpers::AuthLink
    include AuthAssistant::ViewHelpers::RestLink        
    include AuthAssistant::ViewHelpers::AuthMenuItem   
    
    # include ActionView::Helpers::UrlHelper
  end
end
    