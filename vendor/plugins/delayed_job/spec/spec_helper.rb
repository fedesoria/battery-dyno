$:.unshift(File.dirname(__FILE__) + '/../lib')

require "rubygems"
require "bundler"
Bundler.setup
require 'rspec'
require 'logger'

require 'delayed_job'
require 'sample_jobs'

Delayed::Worker.logger = Logger.new('/tmp/dj.log')
RAILS_ENV = 'test'

# determine the available backends
BACKENDS = []
Dir.glob("#{File.dirname(__FILE__)}/setup/*.rb") do |backend|
  begin
    backend = File.basename(backend, '.rb')
    require "setup/#{backend}"
    require "backend/#{backend}_job_spec"
    BACKENDS << backend.to_sym
  rescue Exception
    puts "Unable to load #{backend} backend: #{$!}"
  end
end

Delayed::Worker.backend = BACKENDS.first


# Add this directory so the ActiveSupport autoloading works
require 'active_support/dependencies'
ActiveSupport::Dependencies.autoload_paths << File.dirname(__FILE__)
