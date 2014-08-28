require 'simplecov'
require 'coveralls'

Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_group 'API', 'lib/linkedin/api'
  add_filter 'spec'
end
