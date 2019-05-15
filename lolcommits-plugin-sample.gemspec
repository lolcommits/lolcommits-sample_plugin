lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lolcommits/sample_plugin/version'

Gem::Specification.new do |spec|
  spec.name        = "lolcommits-sample_plugin"
  spec.version     = Lolcommits::SamplePlugin::VERSION
  spec.authors     = ["Matthew Hutchinson"]
  spec.email       = ["matt@hiddenloop.com"]
  spec.summary     = %q{Example gem for lolcommits plugin development}
  spec.homepage    = "https://github.com/lolcommits/lolcommits-sample_plugin"
  spec.license     = "LGPL-3"
  spec.description = %q{Use this gem as a guide or template to get started with lolcommits plugin development}

  spec.metadata = {
    "homepage_uri"    => "https://github.com/lolcommits/lolcommits-sample_plugin",
    "changelog_uri"   => "https://github.com/lolcommits/lolcommits-sample_plugin/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/lolcommits/lolcommits-sample_plugin",
    "bug_tracker_uri" => "https://github.com/lolcommits/lolcommits-sample_plugin/issues",
  }

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|features)/}) }
  spec.test_files    = `git ls-files -- {test,features}/*`.split("\n")
  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_runtime_dependency "lolcommits", "0.14.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
end
