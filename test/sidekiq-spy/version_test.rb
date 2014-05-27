require_relative '../helper'

require_relative '../../lib/sidekiq-spy/version'


describe "SidekiqSpy::VERSION" do
  
  it "uses major.minor.patch" do
    SidekiqSpy::VERSION.must_match /\A\d+\.\d+\.\d+\z/
  end
  
end
