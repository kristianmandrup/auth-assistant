module AuthAssistant::View
  module Host
    def for_localhost(&block)
      with_output_buffer(&block) if localhost?      
    end  

    def for_public(&block)
      with_output_buffer(&block) if publichost?
    end  
  end
end