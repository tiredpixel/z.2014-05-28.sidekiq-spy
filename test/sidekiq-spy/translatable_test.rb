require_relative '../helper'

require_relative '../../lib/sidekiq-spy/translatable'


describe SidekiqSpy::Translatable do
  
  before do
    @klass = Class.new
    
    @klass.extend(SidekiqSpy::Translatable)
  end
  
  it "mixes in #t" do
    @klass.must_respond_to(:t)
  end
  
end
