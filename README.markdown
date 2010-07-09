# User and Permission System Assistant (Auth-Assistant) #

Provides assistance in setting up a complete user login and role permission system solution for your Rails 3 app. 
I am currently targeting:

## User login systems
 * [devise](http://github.com/plataformatec/devise) 

* Permission systems 
* [cancan](http://github.com/ryanb/cancan)
* [canable](http://github.com/jnunemaker/canable) - in the near future

_Note:_
You are most welcome to provide "plugins" for other similar frameworks or perhaps add role/group support or suggest any system that support grouping of roles.
I think Document DBs such as Mongo and Riak are perfect to for modelling a role group hierarchical relationship, whereas it becomes a nightmare in a relational system. 

## Installation and configuration ##

This gem has been designed for Rails 3 only.

See _INSTALLATION.txt_ or [Installation](http://wiki.github.com/kristianmandrup/auth-assistant/installation)

## Role strategies ##

For details on the available role strategies see _ROLE_STRATEGIES.txt__ or [Role strategies](http://wiki.github.com/kristianmandrup/auth-assistant/role-strategies) 

## Permits CanCan ##

Role based authorization is setup by creating 'permits' for each kind of role, in order to permit that role to do certain actions.
The *config* generator generates a default <code>permits.rb</code> file in /lib

See _PERMITS.txt_ or [Permits](http://wiki.github.com/kristianmandrup/auth-assistant/permits)

## Permits Canable ##

In Canable the permissions are by default defined in the models. I can tweak this behavior to enable the same central permission setup as I use for CanCan (which is also a tweak of the default usage setup). My current branch of Canable contains generators to setup the models and user with a Canable config. 
More to follow when I get further here...

## Generators ##

The following generators are currently available 

* config - configure with new strategy
* clear - clear existing strategy
* views - generate partials for use in views

So far they only work for Active Record as the ORM. I pkan to support other ORMs in the future such as Mongo Mapper, Mongoid and Data Mapper.
Any help in this regard would be very much appreciated! fork ahead!

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
