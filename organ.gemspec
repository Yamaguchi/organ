# frozen_string_literal: true

require_relative 'lib/organ/version'

Gem::Specification.new do |spec|
  spec.name          = 'organ'
  spec.version       = Organ::VERSION
  spec.authors       = ['Hajime Yamaguchi']
  spec.email         = ['gen.yamaguchi0@gmail.com']

  spec.summary       = 'gem for organization structure'
  spec.description   = 'gem for organization structure'
  spec.homepage      = 'https://github.com/Yamaguchi/organ'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Yamaguchi/organ'
  spec.metadata['changelog_uri'] = 'https://github.com/Yamaguchi/organ/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activerecord'
  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'ancestry'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'factory_bot'
end
