require 'auth-assistant'
AuthAssistant.configure do
  role_strategy = <%= AuthAssistant::Model.strategy(name) %>
end