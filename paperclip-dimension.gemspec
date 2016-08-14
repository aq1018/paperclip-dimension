$:.push File.expand_path('../lib', __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name          = 'paperclip-dimension'
  s.version       = Paperclip::Dimension::VERSION
  s.authors       = ['Aaron Qian']
  s.email         = ['aq1018@gmail.com']
  s.description   = 'A simple plugin to persist image dimensions.'
  s.summary       = 'A simple plugin to persist image dimensions.'
  s.homepage      = 'http://github.com/aq1018/paperclip-dimension'
  s.licenses      = ['MIT']

  s.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  s.test_files    = Dir.glob('{perf,spec}/**/*')
  s.require_paths = ['lib']

  s.add_runtime_dependency 'paperclip', '>= 3.0'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'gem-release'
end
