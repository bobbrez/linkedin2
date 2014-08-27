require 'simplecov'

SimpleCov.start do
  add_group 'API', 'lib/linkedin/api'
  add_filter 'spec'
end
