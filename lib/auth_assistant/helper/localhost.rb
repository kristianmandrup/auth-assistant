module AuthAssistant
  module Helpers
    module LocalHost
      def for_localhost(&block)
        with_output_buffer(&block) if localhost?      
      end  

      def for_public(&block)
        with_output_buffer(&block) if !localhost?
      end  
  
      def localhost?
         ['localhost', '127.0.0.1'].include?(request.host)
      end           
    end
  end
end