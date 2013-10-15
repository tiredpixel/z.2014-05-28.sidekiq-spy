require 'coveralls'
Coveralls.wear! do
  add_filter "/test/sidekiq-spy/"
end

require 'minitest/autorun'
