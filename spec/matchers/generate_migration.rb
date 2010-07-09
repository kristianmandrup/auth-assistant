# This method manipulates the given path and tries to find any migration which
# matches the migration name. For example, the call above is converted to:
#
#   generator.should generate_migration "db/migrate/003_create_products.rb"
#
# Consequently it accepts the same arguments as the matcher have_file.

module RSpec::Rails
  module GeneratorMatchers
    class GenerateMigration

      def initialize(relative)
        @relative = relative      
      end

      # actual is the generator
      def matches?(generator)      
        migration_file_name(relative, generator)        
      end          
    
      def failure_message
        "Expected migration #{relative} to have been generated, but it was not"
      end
      
      protected
      
      def migration_file_name(relative, generator) #:nodoc:
        absolute = File.expand_path(relative, generator.class.destination_root)
        dirname, file_name = File.dirname(absolute), File.basename(absolute).sub(/\.rb$/, '')
        Dir.glob("#{dirname}/[0-9]*_*.rb").grep(/\d+_#{file_name}.rb$/).first
      end
      
    end
  end
  
  def generate_migration(relative)
    GenerateMigration.new(relative)
  end
  
end
