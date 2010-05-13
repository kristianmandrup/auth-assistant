require 'action_view/helpers/url_helper'

module AuthAssistant
  module ViewHelpers
    module RestLink      
      def create_link(object, label = nil)
        label ||= auth_labels[:new] 
        path = send :"new_#{object.class.to_s.downcase}_path"    
        link = link_to(label, path) if can?(:create, object)
      end

      def edit_link(object, label = nil)
       label ||= auth_labels[:edit]
       link_to(label, [:edit, object]) if can?(:edit, object)
      end

      def delete_link(object, options = nil)    
        options ||= {:label => auth_labels[:delete], :confirm => auth_labels[:confirm]}        
        case options
        when String
          label = options
        when Hash
          label = options[:label]
          confirm_msg = options[:confirm]
        when Array
          label = options[0]
          confirm_msg = options.size > 1 ? options[1] : auth_labels[:confirm]
        end
       link_to(label, object, :method => :delete, :confirm => confirm_msg) if can?(:destroy, object)
      end

      def show_link(object, label = nil) 
        label ||= auth_labels[:show] 
        link_to(label, object)  if can?(:read, object)
      end
      
      alias_method :new_link, :create_link
      alias_method :destroy_link, :delete_link
      alias_method :update_link, :edit_link
      alias_method :read_link, :show_link                  

      # 
      # def self.included(base)  
      #   base.helper_method :create_link, :delete_link, :edit_link, :show_link
      #   base.helper_method :new_link, :destroy_link, :update_link, :read_link                        
      # end
      
    end    
  end
end
