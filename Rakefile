require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "paperclip-dimension"
  gem.homepage = "http://github.com/aq1018/paperclip-dimension"
  gem.license = "MIT"
  gem.summary = %Q{A simple plugin to persist image dimensions.}
  gem.description = %Q{A simple plugin to persist image dimensions.}
  gem.email = "aq1018@gmail.com"
  gem.authors = ["Aaron Qian"]

  # this directory is generated by running the test, and should be ignored...
  gem.files.exclude 'public'
end

Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.rspec_opts = "--color --format progress"
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
