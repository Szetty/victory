lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'victory/version'
require_relative 'extensions'

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
  spec.extensions    = extensions.map { |extension| "ext/#{extension.path}/extconf.rb" }

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'rspec'

  spec.add_runtime_dependency 'concurrent-ruby', '~> 1.1.6'
  spec.add_runtime_dependency 'rgl', '~> 0.5.4'
  spec.add_runtime_dependency 'abstract_method'
end
