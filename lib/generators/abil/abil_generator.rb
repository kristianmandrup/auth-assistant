module AuthAssistant
  module Generators
    class AbilGenerator < Rails::Generators::Base
      desc "Generates ability model for can-can auth framework" 

      def self.source_root
        @_devise_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_ability_model
        copy_file 'ability.rb', 'app/models/ability.rb'
      end

    end
  end
end