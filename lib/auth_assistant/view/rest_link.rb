module AuthAssistant
  module ViewHelpers
    module RestLink
      def create_link(object, label = auth_labels[:new])
       get_link(label, [:new, object]) if can?(:create, object)
      end

      def edit_link(object, label = auth_labels[:edit])
       get_link(label, [:edit, object]) if can?(:edit, object)
      end

      def delete_link(object, options = {:label => auth_labels[:delete], :confirm => auth_labels[:confirm]})    
        case options
        when String
          label = options
        when Hash
          label = options[:label]
          confirm_msg = options[:confirm]
        when Array
          label = options[0]
          confirm_msg = options.size > 1 ? options[1] : auth_labels[:confirm]
        end
       get_link(label, object, :method => :delete, :confirm => confirm_msg) if can?(:destroy, object)
      end

      def show_link(object, label = auth_labels[:show])
       get_link(label, object) if can?(:read, object)
      end
      
      alias_method :new_link, :create_link
      alias_method :destroy_link, :delete_link
      alias_method :update_link, :edit_link
      alias_method :read_link, :show_link                  

      def get_link(*args, &block)
        if block_given?
          options      = args.first || {}
          html_options = args.second
          concat(get_link(capture(&block), options, html_options))
        else
          name         = args.first
          options      = args.second || {}
          html_options = args.third

          url = url_for(options)

          if html_options
            html_options = html_options.stringify_keys
            href = html_options['href']
            convert_options_to_javascript!(html_options, url)
            tag_options = tag_options(html_options)
          else
            tag_options = nil
          end

          href_attr = "href=\"#{url}\"" unless href
          "<a #{href_attr}#{tag_options}>#{name || url}</a>".html_safe
        end
      end

      
      def self.included(base)  
        base.helper_method :create_link, :delete_link, :edit_link, :show_link
        base.helper_method :new_link, :destroy_link, :update_link, :read_link                        
      end
      
    end    
  end
end
