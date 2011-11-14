require 'json'

class TestBalancer::Feature < TestBalancer::Test

  # TODO remove DISPLAY=:1 once the ec2 boxes are properly setup
  # TODO remove bundler dependency
  # TODO switch back to progress
  COMMAND = %w{
    DISPLAY=:1 &&
    bundle exec cucumber
    --format pretty
    --format pretty --out log/cucumber.log
    --format json --out log/cucumber.json
    --require 'test_balancer/features/formatter'

  }.join(' ')
      # --format TestBalancer::Features::Formatter --out log/cucumber.times

  def self.all root
    root     = Pathname.new(File.expand_path(root))
    features = []

    system %{cd "#{root}" && bundle exec cucumber -P --dry-run --format json --out tmp/cucumber.json features/ &>/dev/null} or
      raise "failed running cucumber to find all features"

    json = root.join('tmp/cucumber.json').read



    JSON.parse(json).each{|feature|
      path = feature['uri']
      feature['elements'].each{|element| features << new(path, element['line'].to_i) }
    }

    features
  end

end
