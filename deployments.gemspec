# -*- encoding: utf-8 -*-
require File.expand_path('../lib/deployments/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexander Korsak"]
  gem.email         = ["alex.korsak@gmail.com"]
  gem.description   = %q{Library for pushing details(commits, tag, username, env) about the current app}
  gem.summary       = %q{Library for pushing details(commits, tag, username, env) about the current app}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "deployments"
  gem.require_paths = ["lib"]
  gem.version       = Deployments::VERSION

  gem.add_dependency('curb')
  gem.add_dependency('grit')
  gem.add_dependency('simple-conf')
  gem.add_dependency('capistrano')
end
