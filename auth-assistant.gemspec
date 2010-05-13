# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{auth-assistant}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-05-13}
  s.description = %q{Provides assistance for setting up an auth solution using devise and cancan auth frameworks}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".DS_Store",
     ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "auth-assistant.gemspec",
     "config/locales/en.yml",
     "lib/.DS_Store",
     "lib/auth-assistant.rb",
     "lib/auth_assistant/configure.rb",
     "lib/auth_assistant/helpers/admin_role.rb",
     "lib/auth_assistant/helpers/all.rb",
     "lib/auth_assistant/helpers/localhost.rb",
     "lib/auth_assistant/helpers/roles.rb",
     "lib/auth_assistant/helpers/user_role.rb",
     "lib/auth_assistant/model/user_config.rb",
     "lib/auth_assistant/role_strategies/all.rb",
     "lib/auth_assistant/role_strategies/role_assignment.rb",
     "lib/auth_assistant/role_strategies/strategy_helper.rb",
     "lib/auth_assistant/translate/authlabels.rb",
     "lib/auth_assistant/view/all.rb",
     "lib/auth_assistant/view/auth_link.rb",
     "lib/auth_assistant/view/auth_menu_item.rb",
     "lib/auth_assistant/view/rest_link.rb",
     "lib/generators/.DS_Store",
     "lib/generators/migration_helper.rb",
     "spec/auth-assistant_spec.rb",
     "spec/generators/ability_gen_spec.rb",
     "spec/sandbox.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/devise-assistant}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Provides assistance for setting up an auth solution}
  s.test_files = [
    "spec/auth-assistant_spec.rb",
     "spec/generators/ability_gen_spec.rb",
     "spec/sandbox.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<devise>, [">= 1.0"])
      s.add_runtime_dependency(%q<cancan>, [">= 1.0"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<devise>, [">= 1.0"])
      s.add_dependency(%q<cancan>, [">= 1.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<devise>, [">= 1.0"])
    s.add_dependency(%q<cancan>, [">= 1.0"])
  end
end

