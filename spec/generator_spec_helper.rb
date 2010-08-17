require 'rubygems'
require 'test/unit'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'

require 'matchers/all'

require 'rails_spec_helper'

# Call configure to load the settings from
# Rails.application.config.generators to Rails::Generators

Rails::Generators.configure!

# require the generators
def require_generators generator_list
  generator_list.each do |name, generators|
    generators.each do |generator_name|
      require File.join('generators', name.to_s, generator_name.to_s, "#{generator_name}_generator")
    end    
  end
end

module GeneratorSpec
  class << self  
    attr_accessor :generator

    def setup                  
      with_generator do |g|
        g.destination File.join(Rails.root)
        g.setup :prepare_destination
        g.setup :copy_routes
      end
    end
    
    def get_generator
      @generator = Rails::Generators::Testcase.new
    end

    def run_generator *args, &block
      generator.run_generator *args
      if block
        block.arity < 1 ? generator.instance_eval(&block) : block.call(generator, self)  
      end      
    end

    def check(&block)
      if block
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
      end      
    end
    
    def with(generator, &block)
      if block
        block.arity < 1 ? generator.instance_eval(&block) : block.call(generator, self)  
      end
    end

    def with_generator &block
      with(get_generator, &block)
    end

    def check_methods methods
      methods.each do |method_name|
        content.should_match /def #{method_name}_by?(user)/
      end
    end
    alias :check_methods :methods

    def check_matchings matchings
      matchings.each do |matching|
        content.should_match /#{Regexp.escape(matching)}/
      end
    end
    alias :check_matchings :matchings

    def check_file file
      generator.should generate_file file
    end
    alias :check_file :file

    def check_class_methods methods
      methods.each do |method_name|
        content.should_match /def self.#{method_name}_by?(user)/
      end
    end
    alias :check_class_methods :class_methods

    def check_view(folder, file_name, strings)
      generator.should generate_file("app/views/#{folder}/#{filename}") do |file_content|
        strings.each do |str|
          content.should_match /#{Regexp.escape(str)}/
        end
      end
    end
    alias :check_view :view

    def check_model(name, clazz, options = {})
      generator.should generate_file("app/models/#{name.underscore}.rb") do |file_content|
        file_content.should have_class user.camelize do |content|
          check_matchings options[:matchings]    
          check_methods(options[:methods])
          check_class_methods(options[:class_methods])
        end
      end            
    end
    alias :check_model :model    
  end # class self
end