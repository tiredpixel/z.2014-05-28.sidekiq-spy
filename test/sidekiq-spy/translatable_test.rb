require File.expand_path('../../helper', __FILE__)

require File.expand_path('../../../lib/sidekiq-spy/translatable', __FILE__)


describe SidekiqSpy::Translatable do
  
  before do
    @klass = Class.new
    
    @klass.extend(SidekiqSpy::Translatable)
  end
  
  it "mixes in #t" do
    @klass.must_respond_to(:t)
  end
  
end
