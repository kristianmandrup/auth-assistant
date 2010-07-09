class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails'))
  end
end

Rails.application = TestApp
Rails.application.config.root = Rails.root


def copy_routes
  routes = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'routes.rb'))
  destination = File.join(Rails.root, "config")
  FileUtils.mkdir_p(destination)
  FileUtils.cp File.expand_path(routes), destination
end
