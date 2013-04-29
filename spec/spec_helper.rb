require 'rubygems'
require 'bundler/setup'

require_relative '../lib/stylesheet.rb'
require_relative '../spec/stubs/fake_request.rb'

include Stylesheet

RSpec.configure do |config|
end