require 'auth-assistant'
require 'permits'

AuthAssistant.configure do
  role_strategy = <%= AuthAssistant::Model.strategy(name).to_sym.inspect %>
end