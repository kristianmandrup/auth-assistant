require 'sugar-high/alias'

module AuthAssistant::View
  module UserActionMenu       

    MENU_ITEMS = {
      :sign_out => :logout, 
      :sign_in => :login, 
      :sign_up => :register,
      :edit_registration => [:edit_user, :edit_account]
    }

    MENU_ITEMS.keys.each do |name|
      class_eval %{
        def #{name}_menu_item tag = 'li'
          wrap(#{name}_link, tag)
        end          
      }      
    end
  
    multi_alias :menu_item, MENU_ITEMS.merge(:options => :after)
  end  
end
