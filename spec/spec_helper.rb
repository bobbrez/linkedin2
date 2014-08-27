$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'rspec/collection_matchers'

require 'dotenv'
Dotenv.load

require 'pry'
require 'pry-byebug'
require 'json'

Dir[File.join './spec/support/**/*.rb'].each { |f| require f }

require File.expand_path('../../lib/linkedin2', __FILE__)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.profile_examples = 10

  Kernel.srand config.seed
  config.order = :random
end

LinkedIn::Client.load 'spec/test_app.yml'
LinkedIn::Client.configure do |config|
  config.access_token = 'AQUJwEF40pJUbVxsW_mujQ3QCiXvlTnMFk55SlfVPYRcAPdsn1oE1Hm8Ldlc61o57k96i04ufG81KFdPJIOSJswXsGyZ0tk9IMZea8sfNXMGMnZgikQJUQPkmRVYVw9BP1qH9tp7hJF32DQtzkBB_NE8xPASPVgXVWbbntChGyYqqDvF1p8'
end
