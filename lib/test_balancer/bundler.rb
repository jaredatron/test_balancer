module TestBalancer::Bundler

  def self.with_clean_env
    Bundler.with_clean_env{
      ENV.delete("BUNDLE_BIN_PATH")
      ENV.delete("BUNDLE_GEMFILE")
      ENV["RUBYOPT"] = ENV["RUBYOPT"].gsub('-rbundler/setup', ' ')
      yield
    }
  end

end
