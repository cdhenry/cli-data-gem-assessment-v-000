require_relative './lib/last_chance_shows/version'

Gem::Specification.new do |s|
  s.name        = 'last-chance-shows'
  s.version     = LastChanceShows::VERSION
  s.date        = '2018-03-01'
  s.summary     = "Last Chance Shows in NYC"
  s.description = "Helps find theater shows that are closing soon New York City."
  s.authors     = ["Chris Henry"]
  s.email       = 'cdhenry@gmail.com'
  s.files       = `git ls-files -z`.split("\x0").reject do |f|
                    f.match(%r{^(test|spec|features)/})
                  end
  s.homepage    = 'https://github.com/cdhenry/cli-data-gem-assessment-v-000/last_chance_shows.git'
  s.license     = 'MIT'
  #s.executables << 'last-chance-shows'

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", ">= 0"
  s.add_development_dependency "nokogiri", ">= 0"
  s.add_development_dependency "pry", ">= 0"
end

#
# lib = File.expand_path("../lib", __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require "last_chance_shows/version"
#
# Gem::Specification.new do |spec|
#   spec.name          = "last_chance_shows"
#   spec.version       = LastChanceShows::VERSION
#   spec.date          = "2018-03-01"
#   spec.authors       = ["'Chris Henry'"]
#   spec.email         = ["'cdhenry@gmail.com'"]
#
#   spec.summary       = %q{This gem will help you find theater shows that are closing soon New York City.}
#   spec.description   = %q{This gem will help you find theater shows that are closing soon New York City.  It will scrape Playbill.com for shows that are closing soon, allow you to select a show you're interested in, and deliver back more information on the show.  (ie. synopsis, days and times, runtime, etc...)}
#   spec.homepage      = "https://github.com/cdhenry/cli-data-gem-assessment-v-000/last_chance_shows.git"
#
#   # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
#   # to allow pushing to a single host or delete this section to allow pushing to any host.
#   if spec.respond_to?(:metadata)
#     spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
#   else
#     raise "RubyGems 2.0 or newer is required to protect against " \
#       "public gem pushes."
#   end
#
#   spec.files         = `git ls-files -z`.split("\x0").reject do |f|
#     f.match(%r{^(test|spec|features)/})
#   end
#   spec.bindir        = "exe"
#   spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
#   spec.require_paths = ["lib"]
#
#   spec.add_development_dependency "bundler", "~> 1.16"
#   spec.add_development_dependency "rake", "~> 10.0"
#   spec.add_development_dependency "rspec", ">= 0"
#   spec.add_development_dependency "nokogiri", ">= 0"
#   spec.add_development_dependency "pry", ">= 0"
# end
