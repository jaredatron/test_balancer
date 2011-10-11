class TestBalancer::Test

  attr_reader :path, :line
  attr_accessor :execution_time

  def initialize path, line=nil, execution_time=0
    @path           = Pathname.new(path)
    @line           = line
    @execution_time = execution_time
  end

  def inspect
    "<#{self.class.name} #{to_s} #{execution_time}s>"
  end

  def to_s
    line.nil? ? path.to_s : "#{path}:#{line}"
  end

end
