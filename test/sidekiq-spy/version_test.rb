require 'minitest/autorun'

require File.expand_path('../../../lib/sidekiq-spy/version', __FILE__)


describe "SidekiqSpy::VERSION" do
  
  it "uses major.minor.patch" do
    SidekiqSpy::VERSION.must_match /\A\d+\.\d+\.\d+\z/
  end
  
end
