$SAFE = 2

class RubyExecuter

  attr_reader :output, :exception, :result


  def execute(code)

    reader, writer = IO.pipe

    pid = fork do
      begin
        @output = capture_stdout { @result = eval(code) }
      rescue Exception => ex
        @exception = ex
      ensure
        reader.close
        writer.write @output
        writer.write "-|-"
        writer.write @exception
        writer.write "-|-"
        writer.write @result
      end
    end
  
    status = Timeout::timeout(20) {
      Process.wait(pid)
    }

    writer.close
    data = reader.read.split("-|-")
    @output = data[0]
    @exception = data[1]
    @result = data[2]

  rescue Timeout::Error => ex
    Process.kill('KILL', pid)
    @exception = ex
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