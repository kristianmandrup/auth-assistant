require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Generator' do
  GeneratorSpec.with_generator do |g, c|
    tests AuthAssist::Generators::ConfigGenerator
    c.setup
  end

  describe '# basic configuration' do

    before :each do
      GeneratorSpec.with_generator do |g, check|    
        g.run_generator
        @gen = g
        @check = check
      end
    end

    # TODO: initialization should be done in a different fashion than relying on load order of initializers!
    it "should create_initializer" do
      @check.file "config/initializers/x_auth_assistant.rb" 
    end

    it "should create default ability setup" do
      @check.file 'app/models/ability.rb'
    end

    it "should create default permits" do
      @check.file 'lib/permits.rb'
    end

    it "should create localization file" do
      @check.file 'config/locales/auth_assist.en.yml'
    end
  
    it "should create and configure user model"
      GeneratorSpec.with_generator do |g, check|
        g.run_generator    
        check.model 'user', 'User', :matchings => ['Active::Record', 'devise']
      end
    end

    it "should create and configure user model" do
      GeneratorSpec.with_generator do |g, check|
        g.run_generator    
        check.model 'admin', 'Admin', :matchings => ['< User', 'devise']
      end
    end
  end
end
