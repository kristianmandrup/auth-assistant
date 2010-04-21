require 'helpers/all'
require 'model/user_config'
require 'role_strategies/all'
require 'translate/authlabels'  
require 'view/all'  

module AuthAssistant
  
  # This module is automatically included methods into all controllers.
  # It also makes some methods available to all views.
  module ControllerAdditions
    module ClassMethods
      include AuthAssistant::Helpers::AdminRole
      include AuthAssistant::Helpers::UserRole
      include AuthAssistant::Helpers::Roles
      include AuthAssistant::Helpers::LocalHost
      include AuthAssistant::Helpers::AuthLabel
    
      def self.included(base)
        base.extend ClassMethods
        # admin_role
        base.helper_method :admin_block, :not_admin_block, :admin_area, :not_admin_area, :admin_or_owner_block, :admin? 
        # user_role
        base.helper_method :user_block, :not_user_block, :user_area, :not_user_area, :user? 
        # roles
        base.helper_method :roles_block, :not_roles_block, :roles_area, :not_roles_area, :role? 
        # localhost
        base.helper_method :localhost_block, :not_localhost_block, :locahost?
        
        # authlabels
        base.helper_method :auth_labels

        # authlink
        base.helper_method :sign_out_link, :sign_in_link, :sign_up_link, :edit_registration_link
        base.helper_method :logout_link, :login_link, :register_link, :edit_profile_link
        # authmenu
        base.helper_method :sign_out_menu_item, :sign_in_menu_item, :sign_up_menu_item, :edit_registration_menu_item
        base.helper_method :logout_menu_item, :login_menu_item, :register_menu_item, :edit_profile_menu_item
        
        # restlink
        base.helper_method :create_link, :delete_link, :edit_link, :show_link
        base.helper_method :new_link, :destroy_link, :update_link, :read_link                
      end      
    end
  end
end

if defined? ActionController
  ActionController::Base.class_eval do
    include AuthAssistant::ControllerAdditions
  end
end
    