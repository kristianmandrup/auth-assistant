require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Generator' do
  let(:generator) { GeneratorSpec.generator }

  GeneratorSpec.with generator do
    destination File.join(Rails.root)
    tests AuthAssist::Generators::ConfigGenerator
    setup :prepare_destination
    setup :copy_routes
  end

  it "should work"  
    name = 'user'
    generator.run_generator
    generator.should generate_file 'app/models/ability.rb'
    generator.should generate_file 'lib/permits.rb'
    generator.should generate_file 'config/locales/auth_assist.en.yml'
  end
end
