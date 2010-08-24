require 'active_support/inflector'
require 'require_all'
require 'auth_assistant/namespaces'    

require 'sugar-high/kind_of'

# require_all File.dirname(__FILE__) + '/auth_assistant/core_ext'

require 'auth_assistant/role'

require_all File.dirname(__FILE__) + '/auth_assistant/helper'
require_all File.dirname(__FILE__) + '/auth_assistant/view'
require 'auth_assistant/configure/rails'

