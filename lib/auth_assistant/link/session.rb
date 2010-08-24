module AuthAssistant::Link
  module Session            
    SESSION_LINKS = {
      :sign_out => :log_out,
      :sign_in  => :log_in
    }

    ACTIONS = [:destroy, :create]

    # new_registration_link, edit_registration_link
    SESSION_LINKS.values.each_with_index do |name, index|
      class_eval %{
        def #{name}_link(options = {})
          label = options[:label] || auth_labels[:#{name}]
          path = #{ACTIONS[index]}_session_path options[:role]
          link_to(label, path)
        end          
      }

    multi_aliases :_before_ => :link, SESSION_LINKS

    protected

    ACTIONS.each do |action|
      class_eval %{    
        def #{action}_session_path(role)                                      
          return send :"#{action}_\#{role}_session_path" if role && role != 'user'           
          #{action}_user_session_path
        end        
      }
    end
  end
end
