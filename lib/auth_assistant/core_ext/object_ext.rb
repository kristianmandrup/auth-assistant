class Object
  def any_kind_of? obj, *kinds
    kinds.each do |kind|
      return true if obj.kind_of? kind
    end
  end
  
  def kind_of_label? obj
    any_kind_of? obj, String, Symbol          
  end

  def last_option *args
    last = args.flatten.last
    last.kind_of?(Hash) ? last : {}    
  end
end