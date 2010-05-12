AuthAssistant.configure do
  role_strategy = <%= AuthAssistant::Model.available_strategies.include?(name.to_sym) ? name.to_sym : ':rolesfield' %>
end