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
      
      def self.included(base)
        base.helper_method :localhost_block, :not_localhost_block, :localhost?      
      end         

    end
  end
end