# auth-assistant #

Provides assistance for setting up an auth solution using devise and cancan auth frameworks.

NOTICE: After a major refactoring effort, this gem has NOT finished and NOT been tested yet. I plan to create a test suite real soon...

## Generators ##

### Config Generator ###

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

### Clear Generator ###

The `clear` generator removes any existing strategy file and optionally generates a migration to remove any tables and fields related to the existing role strategy.
This allows you to easily change role strategy by first running the `clear` generator and then the `config` generator with a new strategy.

`$ rails g auth_assistant:clear`                              

### Ability Generator ###

The `ability` generator generates a skeleton for the ability.rb model file for use with `cancan`.

`$ rails g auth_assistant:ability`

The `config` generator generates a configuration initializer file for setting up `auth_assistant` to use a particular role strategy.
A migration can also be generated to add the appropriate field to the User model (or to add and connect a Role model). 



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
