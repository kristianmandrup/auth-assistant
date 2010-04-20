module AuthAssistant
  module Helpers
    module Localhost
      def localhost(&block)
        with_output_buffer(&block) if localhost? && port?(3000)      
      end  
  
      protected
        def localhost?
           ['localhost', '127.0.0.1'].include?(request.host)
        end

        def port?(port_number)
           request.port == port_number
        end  
    end
  end
end