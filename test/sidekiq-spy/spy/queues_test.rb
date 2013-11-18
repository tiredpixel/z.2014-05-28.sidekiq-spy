require 'time'


require File.expand_path('../../../helper', __FILE__)

require File.expand_path('../../../../lib/sidekiq-spy/spy/queues', __FILE__)


describe SidekiqSpy::Spy::Queues do
  
  before do
    @sidekiq_queues_data = {
      'queue1' => 42,
    }
    
    @spy_queues_data = {
      'queue1' => {
        :name => 'queue1',
        :size => 42,
      }
    }
    
    @sidekiq_queues_data2 = {
      'queue2' => 1764,
    }
    
    @spy_queues_data2 = {
      'queue2' => {
        :name => 'queue2',
        :size => 1764,
      }
    }
    
    Sidekiq::Stats.stubs(:new).returns(stub(
      :queues => @sidekiq_queues_data
    ))
    
    @queues = SidekiqSpy::Spy::Queues.new
  end
  
  describe "#initialize" do
    it "sets data list of queues" do
      @queues.data.must_equal(@spy_queues_data)
    end
  end
  
  describe "#refresh" do
    it "doesn't refresh if not called" do
      @sidekiq_queues_data.merge!(@sidekiq_queues_data2)
      
      @queues.data.must_equal(@spy_queues_data)
    end
    
    it "refreshes if called" do
      @sidekiq_queues_data.merge!(@sidekiq_queues_data2)
      
      @queues.refresh
      
      @queues.data.must_equal(@spy_queues_data.merge(@spy_queues_data2))
    end
  end
  
end
