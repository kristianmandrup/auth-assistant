# Asserts a given file exists. You need to supply an absolute path or a path relative
# to the configured destination:
#
#   generator.should have_generated_file "app/controller/products_controller.rb" 
#            

module RSpec::Rails
  module GeneratorMatchers
    class GenerateFile

      def initialize(relative)
        @relative = relative      
      end

      # actual is the generator
      def matches?(generator)      
        @expected = File.expand_path(@relative, generator.class.destination_root)
        File.exists?(@expected)
      end          
    
      def failure_message
        "Expected file #{@relative} to have been generated, but it was not"
      end
    end
  end
  
  def generate_file(relative)
    GenerateFile.new(relative)
  end
  alias :generate_directory :generated_file  
  
end
