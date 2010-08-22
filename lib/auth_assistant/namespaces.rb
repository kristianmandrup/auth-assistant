module AuthAssistant
  NAMESPACES = [:view, :controller, :model, :link, :helper]

  NAMESPACES.each do |namespace|
    class_eval %{
      module #{namespace.to_s.camelize}
      end
    }
  end
end