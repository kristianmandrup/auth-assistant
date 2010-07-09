require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Generator' do
  let(:generator) { GeneratorSpec.generator }

  GeneratorSpec.with generator do
    destination File.join(Rails.root)
    tests AuthAssist::Generators::ClearGenerator
    setup :prepare_destination
    setup :copy_routes
  end

  it "should work"  
    name = 'user'
    generator.run_generator
    GeneratorSpec.check_model(name)      
  end
end
