require 'auth_assistant/helpers/all'
require 'auth_assistant/model/user_config'
require 'auth_assistant/translate/authlabels'  
require 'auth_assistant/view/all'  

if defined? ActionController
  ActionController::Base.class_eval do 
    include AuthAssistant::Helpers::AdminRole
    include AuthAssistant::Helpers::UserRole
    include AuthAssistant::Helpers::Roles
    include AuthAssistant::Helpers::LocalHost
    include AuthAssistant::Helpers::AuthLabel    
  end
else
    puts "ActionController not defined"  
end