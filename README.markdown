# Auth-Assistant

This project aims to assist you in setting up a complete user login and role permission system for your Rails 3 app.
It targets Devise as the user/login system and cancan as the permission system and my own role systems, all integrated in a powerful, yet flexible solution.

## Specs progress (done)

* configure/rails_spec - specs that plugin is configured correct with rails, extending View and Controller
* view
  * host_area_spec - host guards work (public and localhost)
  * role_area_spec - role guards work
  * role_ext_spec - role logic is made available in views

Near future:
* link helpers
* permission system 

Future:
* Add more specs...
* Add *Cucumber* (or *Steak*) acceptance tests

Gems related:
* Update all *roles_for* ORM gems to implement [Generic Role Strategies](http://github.com/kristianmandrup/roles_generic) API
* Investigate latest changes in *CanCan* and *Devise*

Plugin config:
* Use *Railtie* where it makes sense!

## User login systems

Auth-Assistant targets [Devise](http://github.com/plataformatec/devise) as the User login system of choice (or Authentication/Authorization - a14n, a13n )

* [devise](http://github.com/plataformatec/devise) 

## Roles

I have now developed a flexible Generic Roles strategy system. This will soon be integrated with *Auth-Assistant*.

* [Generic Role Strategies](http://github.com/kristianmandrup/roles_generic)

Roles for popular ORMs

* [Roles for Active Record](http://github.com/kristianmandrup/roles_for_ar)
* [Roles for DataMapper](http://github.com/kristianmandrup/roles_for_dm)
* [Roles for MongoMapper](http://github.com/kristianmandrup/roles_for_mm)
* [Roles for Mongoid](http://github.com/kristianmandrup/roles_for_mongoid)

_Role Groups_
I think Document DBs such as *Mongo* and *Riak* are perfect for modeling a role-group hierarchical relationship. 
It quickly becomes something of a nightmare in a relational DB system. 
Role-Group support is planned as a future add-on for the roles strategies integration.

_Note:_
You are most welcome to provide "plugins" for any other role frameworks. Please follow the API conventions of Roles generic.

## Permission systems 

There will be support for multiple permission systems:

* [CanCan](http://github.com/ryanb/cancan)
* [Canable](http://github.com/jnunemaker/canable)

_Note:_
You are most welcome to provide "plugins" for other permission frameworks.

## Installation and configuration ##

This gem has been designed for Rails 3 only.

## Install gems

Insert <pre>gem 'auth-assistant'</pre> in your Rails 3 Gemfile
<pre>$ bundle install</pre>

## Install as plugin

In the near future...

<code>rails plugin install http://github.com/kristianmandrup/auth-assistant.git</code>

## Role strategies ##

Role strategies can be set up using the [Generic Role Strategies](http://github.com/kristianmandrup/roles_generic) gem. 
Follow the instruction on the main page.

_Future plans:_
I have plans to have the main *Auth-Assistant* generator configure a role strategy of choice for the ORM of choice. 

## Permits

### CanCan

Role based authorization for [CanCan](http://github.com/ryanb/cancan) is setup by creating 'permits' for each kind of role. 
A *permit* lets a user in a given role do certain actions. 

The *config* generator generates a default <code>permits.rb</code> file which is placed in /lib, which you can edit to suit your needs.

### Canable

In [Canable](http://github.com/jnunemaker/canable) the permissions are by default defined in the models. 
I plan to tweak this behavior to enable the same or a similar central permission setup as I use for CanCan.
My current branch of *Canable* contains generators to setup the models and user with a *Canable* config. 
More to follow when I get further here...

## Generators

The following generators are currently available 

* config - configure with new strategy
* views  - generate partials for user action menu items

The *config* generator should automatically setup up your project with Devise, a Roles strategy of choice a Permission system of choice and all using an ORM of your choice! 
Auth-Assistant will support these ORMs:

* Mongo Mapper
* Mongoid 
* Data Mapper

### Config Generator ###

<code>rails g auth_assist_::config ROLE_STRATEGY [--devise] [--admin] [--orm]</code>

* --devise  : run devise configure generator
* --admin   : create admin user
* --orm     : orm to be used

### Views Generator ###

Moves 'user menu' partials views into app/views/_user_menu

<code>rails g auth_assist::views [scope] [--haml]</code>

* scope  : The scope folder under views to copy the partials to, fx 'admin'
* --haml : Use HAML as template language

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
