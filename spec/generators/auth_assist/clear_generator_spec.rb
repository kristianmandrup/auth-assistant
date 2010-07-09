require 'generator_helper'

class Mongoid::Generators::ModelGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Mongoid::Generators::ModelGenerator

  setup :prepare_destination
  setup :copy_routes

  def assert_model(name, options)
    assert_file "app/models/#{name}.rb" do |account|
      assert_class name.camelize, account do |klass|
        assert_match /include Canable::Ables/, klass

        assert_match(/userstamps!/, klass) if options[:userstamps]

        if method = options[:method]
          assert_match(/def #{method}_by?(user)/, klass) if method
        end
      end
    end
  end 
  
  # test include Canable:Ables statement is added
  test "invoke with model name" do
    name = 'house'
    run_generator(name)
    assert_model(name)
  end  
end