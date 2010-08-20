module AuthAssistant::View::Helpers
  module Area
    # create a div tag with the given class and let block render within this div
    def for_area(clazz, &block)
      content = with_output_buffer(&block)
      content_tag :div, content, :class => clazz    
    end    
  end
end