require 'time'


require_relative '../../helper'

require_relative '../../../lib/sidekiq-spy/spy/workers'


describe SidekiqSpy::Spy::Workers do
  
  before do
    @sidekiq_workers_data = {
      'worker1' => {
        'queue'  => 'Q',
        'run_at' => 11202710605,
        'payload' => {
          'class' => 'Geometry',
          'args'  => ['Euclid', 360],
        }
      },
    }
    
    @spy_workers_data = [
      {
        :name       => 'worker1',
        :queue      => 'Q',
        :class      => 'Geometry',
        :args       => ['Euclid', 360],
        :started_at => Time.parse('2325-01-01 00:03:25 +0000'),
      },
    ]
    
    @sidekiq_workers_data2 = {
      'worker2' => {
        'queue'  => 'Queueueue',
        'run_at' => -1316908800,
        'payload' => {
          'class' => 'Elements',
          'args'  => ['Lehrer', 102],
        }
      },
    }
    
    @spy_workers_data2 = [
      {
        :name       => 'worker2',
        :queue      => 'Queueueue',
        :class      => 'Elements',
        :args       => ['Lehrer', 102],
        :started_at => Time.parse('1928-04-09 00:00:00 +0000'),
      },
    ]
    
    Sidekiq::Workers.stubs(:new).returns(@sidekiq_workers_data)
    
    @workers = SidekiqSpy::Spy::Workers.new
  end
  
  describe "#initialize" do
    it "sets list of workers" do
      @workers.to_a.must_equal(@spy_workers_data)
    end
  end
  
  describe "#refresh" do
    it "doesn't refresh if not called" do
      @sidekiq_workers_data.merge!(@sidekiq_workers_data2)
      
      @workers.to_a.must_equal(@spy_workers_data)
    end
    
    it "refreshes if called" do
      @sidekiq_workers_data.merge!(@sidekiq_workers_data2)
      
      @workers.refresh
      
      @workers.to_a.must_equal(@spy_workers_data + @spy_workers_data2)
    end
  end
  
end
