class TestBalancer::Spec < TestBalancer::Test


  # TODO remove bundler dependency
  # TODO switch back to progress
  COMMAND = "bundle exec spec --format specdoc --format specdoc:log/spec.log"

  def self.all root
    root = Pathname.new(root)
    return Dir[root.join('spec/**/*_spec.rb')].map{ |path|
      new(Pathname.new(path).relative_path_from(root))
    }
  end

end