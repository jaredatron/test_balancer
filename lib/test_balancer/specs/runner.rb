require 'pathname'

class TestBalancer::Specs::Runner < Spec::Runner::ExampleGroupRunner

  def initialize options, _
    super(options)
  end

  def run
    @spec_file_times = {}

    prepare
    success = true
    example_groups.each do |example_group|
      spec_path = spec_path_for(example_group)
      t1        = Time.now
      success   = success & example_group.run(@options)
      t2        = Time.now

      if spec_path
        @spec_file_times[spec_path] ||= 0.0
        @spec_file_times[spec_path] += t2 - t1
      end
    end

    Rails.root.join('tmp/spec_times').open('w') do |file|
      @spec_file_times.each { |spec_path, time| file.write("#{spec_path}:#{time.to_s}\n") }
    end

    finish
    success
  end

  private

  def spec_path_for example_group
    return nil if example_group.location.nil?
    example_group.location.split(':').first.split('change/').last
  end

end
