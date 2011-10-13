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
        "#{test_class::COMMAND} #{tests_subset.join(' ')}"
      }.join('; ')
    }
  end


  # def all
  #   @all ||= features + specs
  # end
  #
  # def features
  #   @features ||= Features.all(root)
  # end
  #
  # def specs
  #   @specs ||= Specs.all(root)
  # end
  #
  # # splits all tests into n groups based on their type (cucumber,spec,etc)
  # # TODO: add magic balancing based on execution time here
  # def balance_for n
  #   return [all.clone] if n == 1
  #   # debugger;1
  #   classes = all.map(&:class).uniq
  #   tests_by_class = all.group_by(&:class)
  #   groups_per_class = n / classes.length
  #   remainder = n - (groups_per_class * classes.length)
  #
  #   groups = {}
  #   classes.each{ |klass, tests| groups[klass] = groups_per_class }
  #
  #   if remainder > 0 # add remainder to the largest class of tests
  #     # for now assume features are slower
  #     groups[TestBalancer::Features::Test] += remainder
  #     # klass = tests_by_class.sort_by{|(k,v)| v.length}.last.first
  #     # puts "#{klass} += #{remainder}"
  #     # groups[klass] += remainder
  #   end
  #
  #   groups.values.inject(&:+) == n or raise "BUG!"
  #
  #   tests_by_class.each{|klass, tests|
  #     groups[klass] = TestBalancer::Tests.new(tests).in_groups(groups[klass], false)
  #   }
  #
  #   groups.values.flatten(1)
  # end

end
