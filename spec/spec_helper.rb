require 'rubygems'
require 'bundler/setup'

require_relative '../lib/stylesheet.rb'
require_relative '../spec/stubs/fake_request.rb'

include Stylesheet

RSpec.configure do |config|
  # enable filtering for examples
  # config.filter_run :wip => nil
  # config.run_all_when_everything_filtered = true
end