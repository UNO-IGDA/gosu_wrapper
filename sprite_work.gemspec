# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprite_work/version'

Gem::Specification.new do |spec|
  spec.name = 'sprite_work'
  spec.version = SpriteWork::VERSION
  spec.authors = ['Kyle Whittington']
  spec.email = ['kyle.thomas.whittington@gmail.com']

  spec.summary = 'A wrapper for the Gosu Ruby library'
  spec.description = 'A wrapper for the Gosu Ruby library'
  spec.homepage = 'https://github.com/UNO-IGDA/sprite_work'
  spec.license = 'GPL-3.0'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail 'RubyGems 2.0 or newer is required '\
         'to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = 'bin'
  spec.executables = %w(console)

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activemodel', '>= 4.0'
  spec.add_runtime_dependency 'activesupport', '>= 4.0'
  spec.add_runtime_dependency 'gosu', '>= 0.10'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
