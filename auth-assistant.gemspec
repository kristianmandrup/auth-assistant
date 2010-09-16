# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{auth-assistant}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-09-16}
  s.description = %q{Provides assistance for setting up an auth solution using devise and cancan auth frameworks}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     "Changelog.txt",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "app/.DS_Store",
     "app/views/.DS_Store",
     "app/views/auth_assist/menu/_admin_login_items.html.erb",
     "app/views/auth_assist/menu/_login_items.html.erb",
     "app/views/auth_assist/menu/_registration_items.html.erb",
     "auth-assistant.gemspec",
     "config/locales/en.yml",
     "features/FEATURE_NOTES.txt",
     "features/permission/adds_permission.feature",
     "features/role_strategy/adds_role_strategy.feature",
     "features/role_strategy/clears_role_strategy.feature",
     "init.rb",
     "lib/auth-assistant.rb",
     "lib/auth_assistant/configure.rb",
     "lib/auth_assistant/configure/after_init/role_config.rb",
     "lib/auth_assistant/configure/rails.rb",
     "lib/auth_assistant/controller/ability.rb",
     "lib/auth_assistant/helper/authlabels.rb",
     "lib/auth_assistant/helper/host.rb",
     "lib/auth_assistant/helper/role.rb",
     "lib/auth_assistant/namespaces.rb",
     "lib/auth_assistant/role.rb",
     "lib/auth_assistant/view/host_area.rb",
     "lib/auth_assistant/view/role_area.rb",
     "lib/auth_assistant/view/user_action_menu.rb",
     "lib/generators/.DS_Store",
     "lib/generators/auth_code_refactor.rb",
     "lib/generators/cream/config/config_generator.rb",
     "lib/generators/cream/config/helpers.rb",
     "lib/generators/cream/views/haml_util.rb",
     "lib/generators/cream/views/views_generator.rb",
     "log/development.log",
     "sandbox/test.rb",
     "spec/auth-assistant/configure/rails_spec.rb",
     "spec/auth-assistant/helper/host_spec.rb",
     "spec/auth-assistant/helper/role_spec.rb",
     "spec/auth-assistant/view/host_area_spec.rb",
     "spec/auth-assistant/view/role_area_spec.rb",
     "spec/auth-assistant/view/role_ext_spec.rb",
     "spec/generator_spec_helper.rb",
     "spec/generators/config_generator.log",
     "spec/generators/cream/config/config_generator_spec.rb",
     "spec/generators/cream/config/config_w_roles.rb",
     "spec/generators/cream/shared_examples.rb",
     "spec/generators/cream/views_generator_spec.rb",
     "spec/spec_helper.rb",
     "wiki/CONFIG_GENERATOR.txt",
     "wiki/DESIGN.txt",
     "wiki/INSTALLATION.txt",
     "wiki/PERMITS.txt",
     "wiki/ROLE_STRATEGIES.txt",
     "wiki/SPEC_NOTES.txt",
     "wiki/VIEWS_GENERATOR.txt",
     "wiki/VIEW_HELPERS.txt"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/devise-assistant}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Provides assistance for setting up an auth solution}
  s.test_files = [
    "spec/auth-assistant/configure/rails_spec.rb",
     "spec/auth-assistant/helper/host_spec.rb",
     "spec/auth-assistant/helper/role_spec.rb",
     "spec/auth-assistant/view/host_area_spec.rb",
     "spec/auth-assistant/view/role_area_spec.rb",
     "spec/auth-assistant/view/role_ext_spec.rb",
     "spec/generator_spec_helper.rb",
     "spec/generators/cream/config/config_generator_spec.rb",
     "spec/generators/cream/config/config_w_roles.rb",
     "spec/generators/cream/shared_examples.rb",
     "spec/generators/cream/views_generator_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0.beta.22"])
      s.add_runtime_dependency(%q<devise>, ["~> 1.1.2"])
      s.add_runtime_dependency(%q<cancan>, ["~> 1.3.4"])
      s.add_runtime_dependency(%q<r3_plugin_toolbox>, ["~> 0.3.6"])
      s.add_runtime_dependency(%q<rspec-action_view>, ["~> 0.3.1"])
      s.add_runtime_dependency(%q<sugar-high>, ["~> 0.2.7"])
      s.add_runtime_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<rails3_artifactor>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<logging_assist>, ["~> 0.1.2"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.0.0.beta.22"])
      s.add_dependency(%q<devise>, ["~> 1.1.2"])
      s.add_dependency(%q<cancan>, ["~> 1.3.4"])
      s.add_dependency(%q<r3_plugin_toolbox>, ["~> 0.3.6"])
      s.add_dependency(%q<rspec-action_view>, ["~> 0.3.1"])
      s.add_dependency(%q<sugar-high>, ["~> 0.2.7"])
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<rails3_artifactor>, ["~> 0.2.0"])
      s.add_dependency(%q<logging_assist>, ["~> 0.1.2"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.0.0.beta.22"])
    s.add_dependency(%q<devise>, ["~> 1.1.2"])
    s.add_dependency(%q<cancan>, ["~> 1.3.4"])
    s.add_dependency(%q<r3_plugin_toolbox>, ["~> 0.3.6"])
    s.add_dependency(%q<rspec-action_view>, ["~> 0.3.1"])
    s.add_dependency(%q<sugar-high>, ["~> 0.2.7"])
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<rails3_artifactor>, ["~> 0.2.0"])
    s.add_dependency(%q<logging_assist>, ["~> 0.1.2"])
  end
end

