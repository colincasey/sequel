require "rake"
require "rake/clean"
require "rake/gempackagetask"
require "spec/rake/spectask"
begin
  require "hanna/rdoctask"
rescue LoadError
  require "rake/rdoctask"
end
require "fileutils"
require "lib/sequel_core/version"

include FileUtils

NAME = 'sequel'
VERS = Sequel.version
CLEAN.include ["**/.*.sw?", "pkg", ".config", "rdoc", "coverage", "www/public/*.html"]
RDOC_OPTS = ["--quiet", "--line-numbers", "--inline-source", '--title', \
    'Sequel: The Database Toolkit for Ruby', '--main', 'README.rdoc']

# Gem Packaging and Release
begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = NAME
    s.rubyforge_project = 'sequel'
    s.version = VERS
    s.platform = Gem::Platform::RUBY
    s.has_rdoc = true
    s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "COPYING"] + Dir["doc/*.rdoc"] + Dir['doc/release_notes/*.txt']
    s.rdoc_options += RDOC_OPTS
    s.summary = "The Database Toolkit for Ruby"
    s.description = s.summary
    s.author = "Jeremy Evans"
    s.email = "code@jeremyevans.net"
    s.homepage = "http://sequel.rubyforge.org"
    s.required_ruby_version = ">= 1.8.4"
    s.files = %w(COPYING CHANGELOG README.rdoc Rakefile) + Dir.glob("{bin,doc,spec,lib}/**/*")
    s.require_path = "lib"
    s.bindir = 'bin'
    s.executables << 'sequel'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

### RDoc
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.options += RDOC_OPTS
  rdoc.rdoc_files.add %w"README.rdoc CHANGELOG COPYING lib/**/*.rb doc/*.rdoc doc/release_notes/*.txt"
end

### Specs
lib_dir = File.join(File.dirname(__FILE__), 'lib')
fixRUBYLIB = Proc.new{ENV['RUBYLIB'] ? (ENV['RUBYLIB'] += ":#{lib_dir}") : (ENV['RUBYLIB'] = lib_dir)}
sequel_core_specs = "spec/sequel_core/*_spec.rb"
sequel_model_specs = "spec/sequel_model/*_spec.rb"
spec_opts = proc{File.read("spec/spec.opts").split("\n")}
rcov_opts = proc{File.read("spec/rcov.opts").split("\n")}

desc "Run core and model specs with coverage"
Spec::Rake::SpecTask.new("spec_coverage") do |t|
  fixRUBYLIB.call
  t.spec_files = FileList[sequel_core_specs, sequel_model_specs]
  t.spec_opts  = spec_opts.call
  t.rcov_opts  = rcov_opts.call
  t.rcov = true
end

desc "Run core and model specs"
task :default => [:spec]
Spec::Rake::SpecTask.new("spec") do |t|
  fixRUBYLIB.call
  t.spec_files = FileList[sequel_core_specs, sequel_model_specs]
  t.spec_opts  = spec_opts.call
end

desc "Run core specs"
Spec::Rake::SpecTask.new("spec_core") do |t|
  fixRUBYLIB.call
  t.spec_files = FileList[sequel_core_specs]
  t.spec_opts  = spec_opts.call
end

desc "Run model specs"
Spec::Rake::SpecTask.new("spec_model") do |t|
  fixRUBYLIB.call
  t.spec_files = FileList[sequel_model_specs]
  t.spec_opts  = spec_opts.call
end

desc "Run integration tests"
Spec::Rake::SpecTask.new("integration") do |t|
  fixRUBYLIB.call
  t.spec_files = FileList["spec/integration/*_test.rb"]
  t.spec_opts  = spec_opts.call
end

%w'postgres sqlite mysql informix oracle ado'.each do |adapter|
  desc "Run #{adapter} specs without coverage"
  Spec::Rake::SpecTask.new("spec_#{adapter}") do |t|
    t.spec_files = ["spec/adapters/#{adapter}_spec.rb"]
    t.spec_opts  = spec_opts.call
  end
end

desc "check documentation coverage"
task :dcov do
  sh %{find lib -name '*.rb' | xargs dcov}
end

### Statistics
STATS_DIRECTORIES = [
  %w(Code   lib/),
  %w(Spec   spec),
].collect { |name, dir| [ name, "./#{dir}" ] }.select { |name, dir| File.directory?(dir) }

desc "Report code statistics (KLOCs, etc) from the application"
task :stats do
  require "extra/stats"
  verbose = true
  CodeStatistics.new(*STATS_DIRECTORIES).to_s
end

desc "uninstall"
task :uninstall do
  sh "gem uninstall sequel"
end

desc "reinstall"
task :reinstall => [:uninstall, :gemspec, :build, :install]