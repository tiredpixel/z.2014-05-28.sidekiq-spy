require File.expand_path('../../helper', __FILE__)

require File.expand_path('../../../lib/sidekiq-spy/config', __FILE__)


describe SidekiqSpy::Config do
  
  describe "default" do
    before do
      @config = SidekiqSpy::Config.new
    end
    
    it "sets host to 127.0.0.1" do
      @config.host.must_equal '127.0.0.1'
    end
    
    it "sets port to 6379" do
      @config.port.must_equal 6379
    end
    
    it "sets database to 0" do
      @config.database.must_equal 0
    end
    
    it "sets namespace to nil" do
      @config.namespace.must_be_nil
    end
    
    it "sets interval to 5" do
      @config.interval.must_equal 5
    end
  end
  
  describe "#url=" do
    before do
      @config = SidekiqSpy::Config.new
    end
    
    it "sets connection string URL when db" do
      @config.url = 'redis://da.example.com:237/15'
      
      @config.url.must_equal 'redis://da.example.com:237/15'
    end
    
    it "sets connection string URL when no db" do
      @config.url = 'redis://da.example.com:237'
      
      @config.url.must_equal 'redis://da.example.com:237/0'
    end
  end
  
  describe "#url" do
    before do
      @config = SidekiqSpy::Config.new
      
      @config.host     = 'da.example.com'
      @config.port     = 237
      @config.database = 42
    end
    
    it "returns connection string URL" do
      @config.url.must_equal 'redis://da.example.com:237/42'
    end
  end
  
end
