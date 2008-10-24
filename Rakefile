require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

desc "Default: run tests"
task :default => "test:multi_verbose"

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

require "date"
Gem.manage_gems
gem_spec = Gem::Specification.new do |s|
	s.name   = "unit_controller"
  s.summary = "UnitController assists with unit testing controllers by stubbing view rendering."
	s.version = "0.1.0"
	s.author = "Dan Manges"
	s.description = s.summary
	s.email = "daniel.manges@gmail.com"
  s.homepage = "http://unit-controller.rubyforge.org"
  s.rubyforge_project = "unit-controller"

  s.files = FileList['{lib,test}/**/*.rb', 'README.markdown', 'LICENSE', 'Rakefile'].to_a
end
Rake::GemPackageTask.new(gem_spec) do |package|
  package.need_zip = false
  package.need_tar = false
end

Rake::Task["gem"].prerequisites.unshift "test:multi"

namespace :gemspec do
  desc "generates unit_controller.gemspec"
  task :generate do
    File.open("unit_controller.gemspec", "w") do |f|
      f.puts "# this file is generated by rake gemspec:generate for github"
      f.write gem_spec.to_ruby
    end
  end
end

RAILS_VERSIONS = %w[1.2.6 2.0.2 2.1.0 2.1.1]

namespace :test do
  desc "test with multiple versions of rails"
  task :multi do
    RAILS_VERSIONS.each do |rails_version|
      puts "Testing with Rails #{rails_version}"
      sh "RAILS_VERSION='#{rails_version}' rake test > /dev/null 2>&1"
    end
  end
  
  task :multi_verbose do
    RAILS_VERSIONS.each do |rails_version|
      sh "RAILS_VERSION='#{rails_version}' rake test"
    end
  end
end

desc "pre-commit task"
task :pc => %w[test:multi gemspec:generate]
