module AuthAssistant
  NAMESPACES = [:view, :controller, :model, :link, :helper]

  NAMESPACES.each do |namespace|
    class_eval %{
      Module.new #{namespace} do
      end
    }
  end
end