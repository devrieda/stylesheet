require 'rubygems'
require 'bundler/setup'

require File.expand_path('../../lib/stylesheet.rb', __FILE__)
require File.expand_path('../../spec/stubs/fake_request.rb', __FILE__)

include Stylesheet

RSpec.configure do |config|
  # enable filtering for examples
  # config.filter_run :wip => nil
  # config.run_all_when_everything_filtered = true
end