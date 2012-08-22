# -*- encoding: utf-8 -*-
require File.expand_path('../lib/svn_helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kudelabs"]
  gem.email         = ["cantin2010@gmail.com"]
  gem.description   = %q{ helper for svn }
  gem.summary       = %q{ helper for svn }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "SVNHelper"
  gem.require_paths = ["lib"]
  gem.version       = SvnHelper::VERSION
end
