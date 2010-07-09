# This method tries to see if a specific method is contained in the generated file.
# It can operate (should) on either a file name or the raw content 
#
#   generated_file_name.should have_method "hello" # 'my/path/say_hello.rb'.should have_method "hello"
#
#   say_hello_file_content.should have_method "hello"
#


module RSpec::Rails
  module GeneratorMatchers
    class HaveMethod

      def initialize(content)
        begin
          @content = File.open(content).read
        rescue
          @content = content      
        end
      end

      # actual is the generator
      def matches?(method)      
        @method = method
        @content =~ /def\s+#{method}\s*(\(.+\))?(.*?)\n/m
      end          
    
      def failure_message
        "Expected there to be the method #{method}, but there wasn't"
      end            
    end
  end
  
  def have_method(method)
    HaveMethod.new(method)
  end
  alias :have_instance_method :have_method 
end


