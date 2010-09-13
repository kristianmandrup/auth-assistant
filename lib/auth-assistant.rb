require 'active_support/inflector'
require 'require_all'
require 'auth_assistant/namespaces'    

require 'sugar-high/alias'
require 'sugar-high/kind_of'
require 'sugar-high/array'

require_all File.dirname(__FILE__) + '/auth_assistant/controller'
require_all File.dirname(__FILE__) + '/auth_assistant/helper'
require_all File.dirname(__FILE__) + '/auth_assistant/view'

