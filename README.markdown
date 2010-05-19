# auth-assistant #

Provides assistance in setting up a complete authorization solution for your Rails 3 app, using [cancan](http://github.com/ryanb/cancan) and [devise](http://github.com/plataformatec/devise)

Note: You are most welcome to provide "plugins" for other similar frameworks or perhaps add role group support.

## Installation and configuration ##

This gem has been designed for Rails 3 only.

See _INSTALLATION.txt_ or [Installation](http://wiki.github.com/kristianmandrup/auth-assistant/installation)

## Role strategies ##

For details on the available role strategies see ROLE_STRATEGIES.txt or [Role strategies](http://wiki.github.com/kristianmandrup/auth-assistant/role-strategies) 

## Permits ##

Authorization is setup by creating 'permitsø for each kind of role, in order to permit that role to do certain actions.
The config generator generates a default permits.rb file in /lib

See _PERMITS.txt_ or [Permits](http://wiki.github.com/kristianmandrup/auth-assistant/permits)

## Generators ##

The following generators are available 

* config - configure with new strategy
* clear - clear existing strategy
* views - generate partials for use in views

### Config Generator ###

The *config* generator is used to configure your Rails app with a role strategy for use with CanCan and Devise.

See [Config Generator](http://wiki.github.com/kristianmandrup/auth-assistant/config-generator)

### Clear Generator ###

The *clear* generator is used to clear a role strategy from your Rails app so you can create a new one from a fresh starting point!

See [Clear Generator](http://wiki.github.com/kristianmandrup/auth-assistant/clear-generator)

### Views Generator ###

The *view* generator is used to generate views to faciliate creation of session and registration menu items.

See [View Generator](http://wiki.github.com/kristianmandrup/auth-assistant/view-generator)

## Note on Patches/Pull Requests ##
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright ##

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
