require 'linkedin2'

require 'rspec'
require 'vcr'
require 'pry'
require 'byebug'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/requests'
  c.hook_into :faraday
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

LinkedIn.load('spec/test_app.yml')
LinkedIn::Client.configure do |config|
  config.access_token = 'AQXjfyOrBFhWJIkcBXi1ubzLZQhQc2CVGoXdgo2I6wirbJejAwhXDIYu-3gnADeNVeRey_m9jvohTG9rAjFhzakL7UkTbXIBC_GlwTHhhUWHTXzWdRgtVu-al9BQ3bDGCkbsaiCJySOkUn5YFPJE-7eFkA5MwZi_4PJZoep0D80yI8svMkk'
end