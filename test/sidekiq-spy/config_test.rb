require 'minitest/autorun'

require File.expand_path('../../../lib/sidekiq-spy/config', __FILE__)
require File.expand_path('../../../lib/sidekiq-spy/app', __FILE__)


describe SidekiqSpy::Config do
  
  before do
    @app = SidekiqSpy::App.new
  end
  
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
    
    it "sets namespace to ''" do
      @config.namespace.must_equal ''
    end
    
    it "sets interval to 5" do
      @config.interval.must_equal 5
    end
  end
  
  describe "configure block main" do
    before do
      @app.configure do |c|
        c.namespace = 'resque'
        c.interval  = 1
      end
      
      @config = @app.config
    end
    
    it "configures namespace" do
      @config.namespace.must_equal 'resque'
    end
    
    it "configures interval" do
      @config.interval.must_equal 1
    end
  end
  
  describe "configure block url" do
    before do
      @app.configure do |c|
        c.url = 'redis://da.example.com:237/42'
      end
      
      @config = @app.config
    end
    
    it "configures host" do
      @config.host.must_equal 'da.example.com'
    end
    
    it "configures port" do
      @config.port.must_equal 237
    end
    
    it "configures database" do
      @config.database.must_equal 42
    end
  end
  
  describe "configure block url-brief" do
    before do
      @app.configure do |c|
        c.url = 'redis://da.example.com'
      end
      
      @config = @app.config
    end
    
    it "configures host" do
      @config.host.must_equal 'da.example.com'
    end
    
    it "configures port" do
      @config.port.must_equal 6379
    end
    
    it "configures database" do
      @config.database.must_equal 0
    end
  end
  
  describe "configure block non-url" do
    before do
      @app.configure do |c|
        c.host      = 'da.example.com'
        c.port      = 237
        c.database  = 42
      end
      
      @config = @app.config
    end
    
    it "configures host" do
      @config.host.must_equal 'da.example.com'
    end
    
    it "configures port" do
      @config.port.must_equal 237
    end
    
    it "configures database" do
      @config.database.must_equal 42
    end
  end
  
end
