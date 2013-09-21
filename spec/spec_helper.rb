require 'linkedin2'

require 'rspec'
require 'vcr'
require 'pry'
require 'byebug'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/requests'
  c.hook_into :faraday
  c.default_cassette_options = { :record => :none }
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end