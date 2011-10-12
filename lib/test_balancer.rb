require "pathname"
require "test_balancer/version"

class TestBalancer

  autoload :Test,     'test_balancer/test'
  autoload :Specs,    'test_balancer/specs'
  autoload :Features, 'test_balancer/features'
  autoload :Tests,    'test_balancer/tests'

  attr_reader :root

  def initialize root
    @root = Pathname.new(root)
  end

  def all
    @all ||= features + specs
  end

  def features
    @features ||= Features.all(root)
  end

  def specs
    @specs ||= Specs.all(root)
  end

  # splits all tests into n groups based on their type (cucumber,spec,etc)
  # TODO: add magic balancing based on execution time here
  def balance_for n
    return [all.clone] if n == 1
    # debugger;1
    classes = all.map(&:class).uniq
    tests_by_class = all.group_by(&:class)
    groups_per_class = n / classes.length
    remainder = n - (groups_per_class * classes.length)

    groups = {}
    classes.each{ |klass, tests| groups[klass] = groups_per_class }

    if remainder > 0 # add remainder to the largest class of tests
      # for now assume features are slower
      groups[TestBalancer::Features::Test] += remainder
      # klass = tests_by_class.sort_by{|(k,v)| v.length}.last.first
      # puts "#{klass} += #{remainder}"
      # groups[klass] += remainder
    end

    groups.values.inject(&:+) == n or raise "BUG!"

    tests_by_class.each{|klass, tests|
      groups[klass] = TestBalancer::Tests.new(tests).in_groups(groups[klass], false)
    }

    groups.values.flatten(1)
  end

end
