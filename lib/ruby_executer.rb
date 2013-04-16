class RubyExecuter

  attr_reader :output, :exception, :result


  def execute(code)
    @output = capture_stdout { @result = eval(code) }
  rescue Exception => ex
    @exception = ex
  end


  # CAPTURING OUTPUT IN RUBY
  # http://thinkingdigitally.com/archive/capturing-output-from-puts-in-ruby/
  def capture_stdout
    output = StringIO.new
    $stdout = output
    yield
    return output.string
  ensure
    $stdout = STDOUT
  end

end