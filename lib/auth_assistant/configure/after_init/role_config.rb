module AuthAssistant::Helper
  module Role    
    # admin?,  guest? ...
    AuthAssistant::Role.available.each do |role|
      class_eval %{
        def #{role}?
          has_role? :#{role}
        end        
      }
    end
  end
end