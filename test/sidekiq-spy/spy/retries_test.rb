require 'time'


require File.expand_path('../../../helper', __FILE__)

require File.expand_path('../../../../lib/sidekiq-spy/spy/retries', __FILE__)


describe SidekiqSpy::Spy::Retries do
  
  before do
    @sidekiq_retries_data = [
      {
        'retry_count'   => 180,
        'queue'         => 'Q',
        'class'         => 'Geometry',
        'args'          => ['Euclid', 360],
        'error_class'   => 'MmmmmmmmPie',
        'error_message' => 'Pie pie pie!',
      },
    ].each { |e| e.define_singleton_method(:at) { Time.at(11202710605) } }
    
    @spy_retries_data = [
      {
        :next_at       => Time.parse('2325-01-01 00:03:25 +0000'),
        :count         => 180,
        :queue         => 'Q',
        :class         => 'Geometry',
        :args          => ['Euclid', 360],
        :error_class   => 'MmmmmmmmPie',
        :error_message => 'Pie pie pie!',
      },
    ]
    
    @sidekiq_retries_data2 = [
      {
        'retry_count' => 90,
        'queue'       => 'Queueueue',
        'class'       => 'Elements',
        'args'        => ['Lehrer', 102],
      },
    ].each { |e| e.define_singleton_method(:at) { Time.at(-1316908800) } }
    
    @spy_retries_data2 = [
      {
        :next_at       => Time.parse('1928-04-09 00:00:00 +0000'),
        :count         => 90,
        :queue         => 'Queueueue',
        :class         => 'Elements',
        :args          => ['Lehrer', 102],
        :error_class   => nil,
        :error_message => nil,
      },
    ]
    
    Sidekiq::RetrySet.stubs(:new).returns(@sidekiq_retries_data)
    
    @retries = SidekiqSpy::Spy::Retries.new
  end
  
  describe "#initialize" do
    it "sets data list of retries" do
      @retries.data.must_equal(@spy_retries_data)
    end
  end
  
  describe "#refresh" do
    it "doesn't refresh if not called" do
      @sidekiq_retries_data.push(*@sidekiq_retries_data2)
      
      @retries.data.must_equal(@spy_retries_data)
    end
    
    it "refreshes if called" do
      @sidekiq_retries_data.push(*@sidekiq_retries_data2)
      
      @retries.refresh
      
      @retries.data.must_equal(@spy_retries_data + @spy_retries_data2)
    end
  end
  
end
