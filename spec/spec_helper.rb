require 'linkedin2'

require 'rspec'
require 'vcr'
require 'pry'
require 'byebug'
require 'simplecov'

SimpleCov.start do
  add_group 'API', 'lib/linkedin/api'
end

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
  config.access_token = 'AQUJwEF40pJUbVxsW_mujQ3QCiXvlTnMFk55SlfVPYRcAPdsn1oE1Hm8Ldlc61o57k96i04ufG81KFdPJIOSJswXsGyZ0tk9IMZea8sfNXMGMnZgikQJUQPkmRVYVw9BP1qH9tp7hJF32DQtzkBB_NE8xPASPVgXVWbbntChGyYqqDvF1p8'
end
