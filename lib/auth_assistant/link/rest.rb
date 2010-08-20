module AuthAssistant
  module ViewHelpers
    module RestLink      
      def index_link(object, label = nil)
        label ||= auth_labels[:index]                   
        puts object.inspect        
        obj = index_obj(object)
        puts "index obj: #{obj.inspect}"   
        path = send :"#{obj}_path"    
        link = link_to(label, path) if can?(:read, object)
      end      
      
      def index_obj(obj)
        o = case obj
        when Array 
          obj.first.class
        when Class
          obj
        else
          obj.class
        end 
        o.name.pluralize.downcase
      end
                  
      def create_link(object, label = nil)
        label ||= auth_labels[:new] 
        path = send :"new_#{object.class.to_s.downcase}_path"    
        link = link_to(label, path) if can?(:create, object)
      end

      def edit_link(object, label = nil)
       label ||= auth_labels[:edit]
       link_to(label, [:edit, object]) if can?(:edit, object)
      end

      def delete_link(object, options = nil)    
        options ||= {:label => auth_labels[:delete], :confirm => auth_labels[:confirm]}        
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
       link_to(label, object, :method => :delete, :confirm => confirm_msg) if can?(:destroy, object)
      end

      def show_link(object, label = nil) 
        label ||= auth_labels[:show] 
        if can?(:read, object)
          puts "can read: #{object}"
          link_to(label, object)  
        else
          puts "no link"
        end
      end

      LINKS = {
        :list     => :index,
        :new      => :create,
        :destroy  => :delete,
        :update   => :edit,
        :read     => :show
      }
      
      # alias_method :list_link, :index_link   and so on...
      aliases_for :before => :link, LINKS           
    end    
  end
end
