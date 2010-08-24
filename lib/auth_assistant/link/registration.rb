module AuthAssistant::Link
  module Registration
    REGISTRATION_LINKS = {
      :new_registration => :sign_up,
      :edit_registration => :edit_profile
    }

    ACTIONS = [:new, :edit]

    # new_registration_link, edit_registration_link
    REGISTRATION_LINKS.keys.each do |name|
      class_eval %{
        def #{name}_link(options = {})          
          label = options[:label] || auth_labels[:#{name}]
          path = #{name}_path options[:role]
          link_to(label, path)
        end          
      }
    end
    multi_alias REGISTRATION_LINKS.merge(:_after_ => :link)  

    protected

    # new_registration_path, edit_registration_path
    REGISTRATION_LINKS.keys.each_with_index do |name, index|
      class_eval %{      
        def #{name}_path(role = :user) 
          get_registration_path :#{ACTIONS[index]}, role
        end
      }
    end

    def get_registration_path action, role = :user
      user_reg_path action, role 
    end      
    
    def user_reg_path action, role = :user 
      send :"#{action}_#{role}_registration_path"
    end
  end
end