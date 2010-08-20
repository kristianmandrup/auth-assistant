module AuthAssistant::Link
  module Registration
    REGISTRATION_LINKS = {
      :new_registration => :sign_up,
      :edit_registration => :edit_profile
    }

    ACTIONS = [:new, :edit]

    # new_registration_link, edit_registration_link
    REGISTRATION_LINKS.values.each do |name|
      class_eval %{
        def #{name}_link(options = {})
          label = options[:label] || auth_labels[:#{name}]
          path = #{name}_path options[:role]
          link_to(label, path)
        end          
      }
    aliases_for :before => :link, REGISTRATION_LINKS

    protected

    # new_registration_path, edit_registration_path
    REGISTRATION_LINKS.values.each_with_index do |name, index|
      class_eval %{      
        def #{name}_path(role) 
          get_registration_path role, #{ACTIONS[index]}
        end
      }
    end

    def get_registration_path role, action
      role.to_sym == :admin ? send :"#{action}_admin_registration_path" : send :"#{action}_user_registration_path"
    end      
  end
end