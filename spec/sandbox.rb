class Hello
  def hi
    puts "hi"
  end
  
  alias_method :hello, :hi
end

Hello.new.hello