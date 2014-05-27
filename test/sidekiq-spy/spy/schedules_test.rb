require 'time'


require_relative '../../helper'

require_relative '../../../lib/sidekiq-spy/spy/schedules'


describe SidekiqSpy::Spy::Schedules do
  
  before do
    @sidekiq_schedules_data = [
      {
        'queue' => 'Q',
        'class' => 'Geometry',
        'args'  => ['Euclid', 360],
      },
    ].each { |e| e.define_singleton_method(:at) { Time.at(11202710605) } }
    
    @spy_schedules_data = [
      {
        :scheduled_at => Time.parse('2325-01-01 00:03:25 +0000'),
        :queue        => 'Q',
        :class        => 'Geometry',
        :args         => ['Euclid', 360],
      },
    ]
    
    @sidekiq_schedules_data2 = [
      {
        'queue' => 'Queueueue',
        'class' => 'Elements',
        'args'  => ['Lehrer', 102],
      },
    ].each { |e| e.define_singleton_method(:at) { Time.at(-1316908800) } }
    
    @spy_schedules_data2 = [
      {
        :scheduled_at => Time.parse('1928-04-09 00:00:00 +0000'),
        :queue        => 'Queueueue',
        :class        => 'Elements',
        :args         => ['Lehrer', 102],
      },
    ]
    
    Sidekiq::ScheduledSet.stubs(:new).returns(@sidekiq_schedules_data)
    
    @schedules = SidekiqSpy::Spy::Schedules.new
  end
  
  describe "#initialize" do
    it "sets list of schedules" do
      @schedules.to_a.must_equal(@spy_schedules_data)
    end
  end
  
  describe "#refresh" do
    it "doesn't refresh if not called" do
      @sidekiq_schedules_data.push(*@sidekiq_schedules_data2)
      
      @schedules.to_a.must_equal(@spy_schedules_data)
    end
    
    it "refreshes if called" do
      @sidekiq_schedules_data.push(*@sidekiq_schedules_data2)
      
      @schedules.refresh
      
      @schedules.to_a.must_equal(@spy_schedules_data + @spy_schedules_data2)
    end
  end
  
end
