
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'victory/version'

Gem::Specification.new do |spec|
  spec.name          = 'victory'
  spec.version       = Victory::VERSION
  spec.authors       = ['Arnold Szederjesi']
  spec.email         = ['szederjesiarnold@gmail.com']

  spec.homepage      = 'https://github.com/Szetty/victory'
  spec.metadata      = {
    'source_code_uri' => 'https://github.com/Szetty/victory',
    'documentation_uri' => 'https://www.rubydoc.info/github/Szetty/victory/master'
  }
  spec.summary       = 'A gem providing all useful algorithms and data structures for programming contests'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib', 'ext']
  spec.extensions    = [
    'ext/algorithms/string/extconf.rb',
    'ext/containers/bst/extconf.rb',
    'ext/containers/deque/extconf.rb',
    'ext/containers/rbtree_map/extconf.rb',
    'ext/containers/splaytree_map/extconf.rb',
    'ext/containers/xor_list/extconf.rb'
  ]

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'rgl', '~> 0.5.4'
  spec.add_development_dependency 'rspec'
end
