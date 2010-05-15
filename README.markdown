# auth-assistant #

Provides assistance for setting up an auth solution using devise and cancan auth frameworks.

Note: The gem seems to be working now. More testing needed. Please report any issues.

## Installation ##

This gem has been designed for Rails 3 only. Any back port to Rails 2 is most welcome ;)

Insert `gem 'auth-assistant'` in your Gemfile
Run `bundle install`

The gem should automatically configure itself with Rails after you run the `config` generator (see below).

To make the extra authentication view helpers accessible from your views

# app/helpers/application_helper.rb

module ApplicationHelper       
  auth_assist_helpers
end


## Generators ##

### Config Generator ###

The `config` generator generates a configuration initializer file for setting up `auth_assistant` to use a particular role strategy.

`$ rails g auth_assistant:config NAME`

NAME is the name of a role strategy. 

Strategies with a single role for each user
* admin_field
* role_field

Strategies with multiple roles for each user
* roles_field
* roles_mask
* roles_model

Currently role groups are not supported. Feel free to provide an add-on to support this or integrate with an existing 'role group' solution.  

Example usage:

$ rails g auth_assistant:config admin_field

Also ensure devise is setup and configured

$ rails g auth_assistant:config roles_mask --devise

To also create an administrator model using STI to inherit and override the basic user strategies

$ rails g auth_assistant:config roles_field --administrator

To ensure a user model migration is generated

$ rails g auth_assistant:config role_field --migration


### Clear Generator ###

The `clear` generator removes any existing strategy file and optionally generates a migration to remove any tables and fields related to the existing role strategy.
This allows you to easily change role strategy by first running the `clear` generator and then the `config` generator with a new strategy.

`$ rails g auth_assistant:clear`                              

### Ability Generator ###

The `ability` generator generates a skeleton for the ability.rb model file for use with `cancan`.

`$ rails g auth_assistant:ability`

### Views Generator ###

The `views` generator generates views (partials) for use with Menus. 

`$ rails g auth_assistant:views` 

Create HAML views

`$ rails g auth_assistant:views --template_engine haml'

Example usage:
<pre>
  ul.menu
    render 'auth_assist/login_items'                              
    render 'auth_assist/registration_items'

  ul.admin_menu_
    render 'auth_assist/admin_login_items'
</pre>

== Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
