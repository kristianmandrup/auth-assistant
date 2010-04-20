module AuthAssistant
  module Generators
    class ConfigGenerator < Rails::Generators::NamedBase
      desc "Generates user role migration and matching auth configuration initializer" 

      def self.source_root
        @_devise_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_initializer
        template "auth_assistant", "config/initializers"
      end
    end
  end
end