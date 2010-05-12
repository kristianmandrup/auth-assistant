module AuthAssistant
  module Helpers
    module LocalHost
      def localhost_block(&block)
        with_output_buffer(&block) if localhost?      
      end  

      def not_localhost_block(&block)
        with_output_buffer(&block) if !localhost?
      end  
  
      def localhost?
         ['localhost', '127.0.0.1'].include?(request.host)
      end
    end
  end
end