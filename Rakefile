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

Gem.manage_gems
Rake::GemPackageTask.new(eval(File.read("unit_controller.gemspec"))) do |package|
  package.need_zip = false
  package.need_tar = false
end

Rake::Task["gem"].prerequisites.unshift "test:multi"

RAILS_VERSIONS = %w[1.2.6 2.0.2]

namespace :test do
  desc "test with multiple versions of rails"
  task :multi do
    RAILS_VERSIONS.each do |rails_version|
      sh "RAILS_VERSION='#{rails_version}' rake test > /dev/null 2>&1"
    end
  end
end
