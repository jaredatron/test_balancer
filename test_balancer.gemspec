# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "test_balancer/version"

Gem::Specification.new do |s|
  s.name        = "test_balancer"
  s.version     = TestBalancer::VERSION
  s.authors     = ["Jared Grippe"]
  s.email       = ["jared@deadlyicon.com"]
  s.homepage    = "https://github.com/deadlyicon/test_balancer"
  s.summary     = %q{inspects, lists and balances you test suit across multiple executions}
  s.description = %q{inspects, lists and balances you test suit across multiple executions}

  s.rubyforge_project = "test_balancer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "ruby-debug"
  s.add_development_dependency "rake"

  s.add_runtime_dependency "json"
end
