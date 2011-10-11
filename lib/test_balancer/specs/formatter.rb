require 'spec/runner/formatter/base_formatter'
# require 'ruby-debug'

class TestBalancer::Specs::Formatter < Spec::Runner::Formatter::BaseFormatter

  def initialize(options, output)
    if String === output
      FileUtils.mkdir_p(File.dirname(output))
      @output = File.open(output, 'w')
    else
      @output = output
    end
  end

  def start(example_count)
    @specs = []
  end

  def close
    @output.puts({:specs => @specs}.to_json)
    @output.flush
    @output.close  if (IO === @output) & (@output != $stdout)
  end

  def example_group_started(example_group_proxy)
    @example_group = example_group_proxy
  end

  def example_pending(example_proxy, message, deprecated_pending_location=nil)
    @pending_examples << {
      :description     => "#{@example_group.description} #{example_proxy.description}",
      :file_colon_line => example_proxy.location,
      :status          => :pending,
      :message         => message,
    }
  end

  def example_started(example_proxy)
    @specs << @current_spec = {
      :description     => "#{@example_group.description} #{example_proxy.description}",
      :file_colon_line => example_proxy.location,
    }
  end

  def example_passed(example_proxy)
    @current_spec[:status] = :passed
  end

  def example_failed(example_proxy, counter, failure)
    @current_spec[:status] = :failed
  end

end
