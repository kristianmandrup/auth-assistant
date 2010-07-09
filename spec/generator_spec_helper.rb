require 'rubygems'
require 'test/unit'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'

require 'matchers/all'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end
Rails.application = TestApp

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails'))
  end
end
Rails.application.config.root = Rails.root

# Call configure to load the settings from
# Rails.application.config.generators to Rails::Generators
Rails::Generators.configure!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

def copy_routes
  routes = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'routes.rb'))
  destination = File.join(Rails.root, "config")
  FileUtils.mkdir_p(destination)
  FileUtils.cp File.expand_path(routes), destination
end

def generator_list
  {
    :canable      => ['model', 'user'],
  }
end

def path_prefix
  'generators'
end

# require the generators
generator_list.each do |name, generators|
  generators.each do |generator_name|
    require File.join(path_prefix(name), name, generator_name, "#{generator_name}_generator")
  end    
end

module GeneratorSpec
  class << self  
    attr_accessor :generator
    
    def get_generator
      @generator = Rails::Generators::Testcase.new
    end

    def run_generator
      generator.run_generator
    end
    
    def with(generator, &block)
      if block
        block.arity < 1 ? generator.instance_eval(&block) : block.call(generator)  
      end
    end

    def check_methods methods
      methods.each do |method_name|
        content.should_match /def #{method_name}_by?(user)/
      end
    end
    alias :check_methods :methods

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

    def check_model(name, options = {})
      generator.should generate_file("app/models/#{user.underscore}.rb") do |file_content|
        file_content.should have_class user.camelize do |content|
          content.should_match /include Canable::Ables/
          content.should_match /userstamps!/
    
          check_methods(options[:methods])
          check_class_methods(options[:class_methods])
        end
      end            
    end
    alias :check_model :model    
  end # class self
end