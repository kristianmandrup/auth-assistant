module AuthAssistant
  module ViewHelpers
    module SessionLink                                                        
      def sign_out_link(options = {})
        label = options[:label] || auth_labels[:sign_out]
        get_link(label, destroy_session_path options[:role])
      end

      def sign_in_link(label, options = {})  
        label = options[:label] || auth_labels[:sign_in]
        get_link(label, create_session_path options[:role])
      end

      alias_method :log_out_link, :sign_out_link
      alias_method :log_in_link, :sign_in_link  

      protected
        def destroy_session_path(role)                                      
          return send :"destroy_#{role}_session_path" if role && role != 'user'           
          destroy_user_session_path
        end

        def create_session_path(role) 
          return send :"new_#{role}_session_path" if role && role != 'user' 
          new_user_session_path # default  
        end            
    end      
  end
end
