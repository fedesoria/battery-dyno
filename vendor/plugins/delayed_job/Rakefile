require "rubygems"
require "bundler"
Bundler.setup

require 'jeweler'
Jeweler::Tasks.new do |s|
  s.name     = "delayed_job"
  s.summary  = "Database-backed asynchronous priority queue system -- Extracted from Shopify"
  s.email    = "tobi@leetsoft.com"
  s.homepage = "http://github.com/collectiveidea/delayed_job"
  s.description = "Delayed_job (or DJ) encapsulates the common pattern of asynchronously executing longer tasks in the background. It is a direct extraction from Shopify where the job table is responsible for a multitude of core tasks.\n\nThis gem is collectiveidea's fork (http://github.com/collectiveidea/delayed_job)."
  s.authors  = ["Brandon Keepers", "Tobias Lütke"]
  
  s.has_rdoc = true
  s.rdoc_options = ["--main", "README.textile", "--inline-source", "--line-numbers"]
  s.extra_rdoc_files = ["README.textile"]
  
  s.test_files = Dir['spec/*_spec.rb']
  
  s.add_dependency "daemons"
  s.add_development_dependency "rspec", '2.0.0.beta.19'
  s.add_development_dependency "sqlite3-ruby"
  s.add_development_dependency "activerecord"
  s.add_development_dependency "bson_ext"
  s.add_development_dependency "mongo_mapper"
  s.add_development_dependency "dm-core"
  s.add_development_dependency "dm-observer"
  s.add_development_dependency "dm-aggregates"
  s.add_development_dependency "dm-validations"
  s.add_development_dependency "do_sqlite3"
  s.add_development_dependency "couchrest"
end

task :default => :spec

require 'rspec/core/rake_task'
desc 'Run the specs'
RSpec::Core::RakeTask.new do |t|
  # t.libs << 'lib'
  t.pattern = 'spec/*_spec.rb'
  t.verbose = true
end
