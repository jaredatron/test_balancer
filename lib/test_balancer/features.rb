require 'json'

module TestBalancer::Features

  autoload :Test, 'test_balancer/features/test'

  extend self

  def all root
    root     = Pathname.new(root)
    features = []
    json     = TestBalancer::Bundler.with_clean_env{
      system %{cd "#{root}" && bundle exec cucumber -P --dry-run --format json features/ | tail -n 1}
    }

    JSON.parse(json)['features'].each{|feature|
      feature['elements'].each{|element|
        path, line = element['file_colon_line'].split(':')
        features << Test.new(path, line)
      }
    }

    features
  end


  private



end