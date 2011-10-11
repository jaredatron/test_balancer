require "json"
require "cucumber/formatter/io"

class TestBalancer::Features::Formatter

  include Io

  def initialize(step_mother, io, options)
    @io = ensure_io(io, "json")
  end

  def before_features(features)
    @features = []
  end

  def scenario_name(keyword, name, file_colon_line, source_indent)
    @features << file_colon_line
  end

  def after_features(features)
    @io.write json_string
    @io.flush
  end

end
