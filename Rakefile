require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require File.join(File.dirname(__FILE__), 'lib', 'fusion_charts', 'version')

PKG_BUILD     = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_NAME      = 'fusioncharts'
PKG_VERSION   = FusionCharts::VERSION::STRING + PKG_BUILD
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

RELEASE_NAME  = "REL #{PKG_VERSION}"

desc "Default Task"
task :default => [ :test ]


# Run the unit tests
Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = 'test/*_test.rb'
  t.verbose = true
}


# Generete the RDoc documentation
Rake::RDocTask.new { |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = "FusionCharts -- Effortless Interaction with Fusion Charts"
  rdoc.options << "--line-numbers"
  rdoc.options << "--inline-source"
  rdoc.template = "#{ENV['template']}.rb" if ENV['template']
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
}

# Create compressed packages
spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = PKG_NAME
  s.summary = "Module for easy interaction with Fusion Charts."
  s.description = %q{Makes it trivial to integrate with Fusion Charts for Flash chart and graph generation.}
  s.version = PKG_VERSION

  s.author = "Justin Mecham"
  s.email = "justin@mecham.net"
  s.homepage = "http://www.observationpoint.org/"

  s.has_rdoc = true
  s.requirements << 'none'
  s.require_path = 'lib'
  s.autorequire = 'fusion_charts'

  s.files = [ "Rakefile", "install.rb", "README" ]
  s.files = s.files + Dir.glob( "lib/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
  s.files = s.files + Dir.glob( "test/**/*" ).delete_if { |item| item.include?( "\.svn" ) }
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
  pkg.need_tar = true
  pkg.need_zip = true
end


#desc "Publish the API documentation"
#task :pgem => [:package] do 
#  Rake::SshFilePublisher.new("[user@host]", "[path]", "pkg", "#{PKG_FILE_NAME}.gem").upload
#end


#desc "Publish the API documentation"
#task :pdoc => [:rdoc] do 
#  Rake::SshDirPublisher.new("[user@host]", "[path]", "doc").upload
#end

