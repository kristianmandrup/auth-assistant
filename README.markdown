# Auth assistant

This project aims to assist you in setting up a complete user login and role permission system for your Rails 3 app.
It targets Devise as the user/login system and cancan as the permission system and my own role systems, all integrated in a powerful, yet flexible solution.

__NOTE__: Aug 2010
This project will undergo a major refactoring effort, hopefully resulting in a powerful, stable version by the end of August or thereabouts!
Stay tuned! Until then, this project should only be looked at as a reference for ideas, inspiration etc.

## User login systems

Devise has been targeted as the User login (auth/auth) system of choice.

* [devise](http://github.com/plataformatec/devise) 

## Permission systems 

There are two similar simple but powerful permission system I plan to support:

* [cancan](http://github.com/ryanb/cancan)
* [canable](http://github.com/jnunemaker/canable) - in the future

_Note:_
You are most welcome to provide "plugins" for other similar frameworks or perhaps add role/group support or suggest any system that support grouping of roles.
I think Document DBs such as Mongo and Riak are perfect for modeling a role group hierarchical relationship, whereas it quickly becomes something of a nightmare in a relational DB system. This is planned as part of the roles strategies integration (see below).

## Roles

I am close to having developed a comprehensive, very flexible Roles strategy system that is to be fully integrated with Auth-assistant in the near future.

## Installation and configuration ##

This gem has been designed for Rails 3 only.

See _INSTALLATION.txt_ or [Installation](http://wiki.github.com/kristianmandrup/auth-assistant/installation)

## Role strategies ##

For details on the available role strategies see _ROLE_STRATEGIES.txt__ or [Role strategies](http://wiki.github.com/kristianmandrup/auth-assistant/role-strategies) 

_Update_ : Aug 2010

I have recently developed a [roles_generic](http://github.com/kristianmandrup/roles_generic) gem, which allows for easy setup of your models for a generic Role strategy.
I have also recently developed a bunch of *roles_for_xxxx* gems, f.ex [roles_for_ar](http://github.com/kristianmandrup/roles_for_ar) which make it simple to add a role strategy for various ORMs. I have plans to integrate these role strategies in the very near future (by end of August, 2010).

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
