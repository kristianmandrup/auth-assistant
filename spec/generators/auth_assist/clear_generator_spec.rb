require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Generator' do
  GeneratorSpec.with_generator do
    destination File.join(Rails.root)
    tests AuthAssist::Generators::ClearGenerator
    setup :prepare_destination
    setup :copy_routes
  end

  it "should clear ..."  
    name = 'user'
    GeneratorSpec.with_generator do |g, check|
      g.run_generator
      # TODO
    end
  end
end
