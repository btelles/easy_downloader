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
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "easy_downloader"
  gem.homepage = "http://github.com/btelles/easy_downloader"
  gem.license = "MIT"
  gem.summary = %Q{One-method downloading, with error handling and friendly messages}
  gem.description = %Q{ EasyDownloader reduces the amount of work required to setup and check for errors when downloading from another location. This 
                      is useful when, for example, a client wants to you to pick a file up from their FTP, SFTP, or regular website on a nightly basis.
                      EasyDownloader gives you a one-method means of downloading those files, returns with a friendly error message if it fails
                      (geared at cron job notifications), or returns an array of file names it downloaded.}
  gem.email = "btelles@gmail.com"
  gem.authors = ["Bernardo Telles"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "easy_downloader #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
