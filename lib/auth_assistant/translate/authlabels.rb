module AuthAssistant
  module AuthLabelHelper          
    protected
      def auth_labels
        @auth_labels ||= translate_labels
      end

      def translate_labels
        ns_actions = 'auth_assistant.actions'
        labels = {}
        %w{new edit delete show sign_in sign_out sign_up edit_registration}.each do |action|     
          labels[action.to_sym] = t "#{ns_actions}.#{action}"
        end 
        labels[:confirm] = t 'auth_assistant.confirm'
        labels           
      end  
  end
end