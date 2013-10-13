require 'minitest/autorun'
require 'redis/namespace'
require 'json'

require File.expand_path('../../../../lib/sidekiq-spy/spy/stats', __FILE__)


describe SidekiqSpy::Spy::Stats do
  
  before do
    @redis = Redis::Namespace.new('resque', :redis => Redis.new)
    
    Sidekiq.configure_client do |config|
      config.redis = ConnectionPool.new(:size => 1, &proc { @redis })
    end
    
    @fixtures = {
      :redis_info => JSON.parse(File.read(
        File.expand_path('../../../fixtures/redis_info.json', __FILE__)
      )),
    }
    
    @sidekiq_stats = Minitest::Mock.new
    @sidekiq_stats.expect(:enqueued,       16776977673)
    @sidekiq_stats.expect(:retry_size,     924984826746)
    @sidekiq_stats.expect(:scheduled_size, 317321542620)
    @sidekiq_stats.expect(:processed,      923531545885)
    @sidekiq_stats.expect(:failed,         779187529140)
    
    @sidekiq_workers = Minitest::Mock.new
    @sidekiq_workers.expect(:size, 162165179294)
    
    Sidekiq::Stats.stub(:new, @sidekiq_stats) do
      Sidekiq::Workers.stub(:new, @sidekiq_workers) do
        @stats = SidekiqSpy::Spy::Stats.new
      end
    end
  end
  
  describe "#connection" do
    it "returns stat connection" do
      @redis.client.stub(:location, 'da.example.com:237') do
        @redis.client.stub(:db, 42) do
          @stats.connection.must_equal 'da.example.com:237/42'
        end
      end
    end
  end
  
  describe "#namespace" do
    it "returns stat namespace" do
      @stats.namespace.must_equal 'resque'
    end
  end
  
  describe "#uptime" do
    it "returns stat uptime" do
      @redis.stub(:info, @fixtures[:redis_info]) do
        @stats.uptime.must_equal '7'
      end
    end
  end
  
  describe "#connections" do
    it "returns stat connections" do
      @redis.stub(:info, @fixtures[:redis_info]) do
        @stats.connections.must_equal '8'
      end
    end
  end
  
  describe "#memory" do
    it "returns stat memory" do
      @redis.stub(:info, @fixtures[:redis_info]) do
        @stats.memory.must_equal '5.16M'
      end
    end
  end
  
  describe "#memory_peak" do
    it "returns stat memory_peak" do
      @redis.stub(:info, @fixtures[:redis_info]) do
        @stats.memory_peak.must_equal '5.14M'
      end
    end
  end
  
  describe "#busy" do
    it "returns stat busy" do
      @stats.busy.must_equal 162165179294
    end
  end
  
  describe "#enqueued" do
    it "returns stat enqueued" do
      @stats.enqueued.must_equal 16776977673
    end
  end
  
  describe "#retries" do
    it "returns stat retries" do
      @stats.retries.must_equal 924984826746
    end
  end
  
  describe "#scheduled" do
    it "returns stat scheduled" do
      @stats.scheduled.must_equal 317321542620
    end
  end
  
  describe "#processed" do
    it "returns stat processed" do
      @stats.processed.must_equal 923531545885
    end
  end
  
  describe "#failed" do
    it "returns stat failed" do
      @stats.failed.must_equal 779187529140
    end
  end
  
end
