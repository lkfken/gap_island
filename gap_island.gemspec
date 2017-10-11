# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gap_island/version'

Gem::Specification.new do |spec|
  spec.name          = "gap_island"
  spec.version       = GapIsland::VERSION
  spec.authors       = ["Kenneth Leung"]
  spec.email         = ["kenneth@leungs.us"]

  spec.summary       = %q{solve Gap & Island the Ruby way}
  spec.description   = %q{solve Gap & Island the Ruby way}
  spec.homepage      = "https://github.com/lkfken/gap_island"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/lkfken/gap_island"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency 'factory_girl'
  spec.add_dependency 'kl-date_range'
end
