require "pathname"
require "test_balancer/version"

class TestBalancer

  autoload :Bundler, 'test_balancer/bundler'
  autoload :Test,    'test_balancer/test'
  autoload :Spec,    'test_balancer/spec'
  autoload :Feature, 'test_balancer/feature'
  autoload :Tests,   'test_balancer/tests'

  attr_reader :root

  def initialize root
    @root = Pathname.new(root)
  end

  def tests
    @tests ||= TestBalancer::Tests.new
  end

  def << tests
    self.tests.push *tests
  end

  def add_features!
    self << Feature.all(root)
  end

  def add_specs!
    self << Spec.all(root)
  end

  def add_all!
    add_features!
    add_specs!
  end

  def generate_commands! n=1
    # TODO: take execution_time into account
    tests.in_groups(n, false).map{ |tests|
      tests.group_by(&:class).map{|test_class, tests_subset|
        # "#{test_class::COMMAND} #{tests_subset.join(' ')}"
        "#{test_class::COMMAND} #{tests_subset.first(2).join(' ')}" #TEMP for faster development
      }.join('; ')
    }
  end``

end
