class TestBalancer::Spec < TestBalancer::Test


  # TODO remove bundler dependency
  # TODO switch back to progress
  COMMAND = "bundle exec rspec --format documentation --format documentation:log/spec.log"

  def self.all root
    root = Pathname.new(root)
    Dir[root.join('spec/**/*_spec.rb')].map{ |path|
      new(Pathname.new(path).relative_path_from(root))
    }
  end

end
