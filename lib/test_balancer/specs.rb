module TestBalancer::Specs

  autoload :Test, 'test_balancer/specs/test'

  extend self

  def all root
    root = Pathname.new(root)
    return Dir[root.join('spec/**/*_spec.rb')].map{ |path|
      Test.new(Pathname.new(path).relative_path_from(root))
    }
  end

end