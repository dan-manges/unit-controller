require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
require 'rake/contrib/sshpublisher'

desc "Default: run tests"
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc "Generate documentation"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title    = "UnitController"
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README')
end

desc "Upload RDoc to RubyForge"
task :publish_rdoc => [:rdoc] do
  Rake::SshDirPublisher.new("dcmanges@rubyforge.org", "/var/www/gforge-projects/unit-controller", "doc").upload
end

Gem::manage_gems

specification = Gem::Specification.new do |s|
	s.name   = "unit_controller"
  s.summary = "UnitController assists with unit testing controllers by stubbing view rendering."
	s.version = "0.1.0"
	s.author = "Dan Manges"
	s.description = s.summary
	s.email = "daniel.manges@gmail.com"
  s.homepage = "http://unit-controller.rubyforge.org"
  s.rubyforge_project = "unit-controller"

  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--title' << "UnitController" << '--main' << 'README' << '--line-numbers'

  s.autorequire = "unit_controller"
  s.files = FileList['{lib,test}/**/*.rb', 'README', 'Rakefile'].to_a
end

Rake::GemPackageTask.new(specification) do |package|
  package.need_zip = false
  package.need_tar = false
end

RAILS_VERSIONS = %w[1.2.6 2.0.2]

namespace :test do
  desc "test with multiple versions of rails"
  task :multi do
    RAILS_VERSIONS.each do |rails_version|
      sh "RAILS_VERSION='#{rails_version}' rake test > /dev/null 2>&1"
    end
  end
end
