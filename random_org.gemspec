# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'random_org'
  s.version     = "0.0.1"
  s.summary     = "Random.org service gem"
  s.description = "Gets array of random integers, strings, sequences and quota check from Random.org's random integer generator via HTTP."
  s.required_ruby_version = '>= 1.8.7'

  s.author      = "Alexandr Andrianov"
  s.homepage    = 'https://github.com/zloydadka/random-org'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'



end
