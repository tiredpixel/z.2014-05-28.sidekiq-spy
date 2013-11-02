require File.expand_path('../../helper', __FILE__)

require File.expand_path('../../../lib/sidekiq-spy', __FILE__)


def start_and_stop_app(app)
  app_thread = Thread.new { app.start }
  
  sleep 1 # patience, patience; give app time to start
  
  app.stop
  
  app_thread.join(2)
  
  Thread.kill(app_thread)
end


describe SidekiqSpy::App do
  
  before do
    SidekiqSpy::Display::Screen.stubs(:new)
    
    @app = SidekiqSpy::App.new
  end
  
  it "sets status not-running" do
    @app.running.must_equal false
  end
  
  describe "#configure" do
    it "configures Sidekiq" do
      Sidekiq.expects(:configure_client)
      
      @app.configure {  }
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
  
  describe "#start" do
    before do
      @app.configure do |c|
        c.interval = 10
      end
    end
    
    it "sets status running within 1s" do
      thread_app = Thread.new { @app.start }
      
      sleep 1 # patience, patience; give app time to start
      
      @app.running.must_equal true
      
      Thread.kill(thread_app)
    end
    
    it "stops running within 1s" do
      thread_app = Thread.new { @app.start }
      
      sleep 1 # patience, patience; give app time to start
      
      @app.stop; t0 = Time.now
      
      thread_app.join(2)
      
      Thread.kill(thread_app)
      
      assert_operator (Time.now - t0), :<=, 1
    end
    
    it "calls #setup hook" do
      @app.expects(:setup)
      
      start_and_stop_app(@app)
    end
    
    it "calls #refresh hook" do
      @app.expects(:refresh)
      
      start_and_stop_app(@app)
    end
    
    it "calls #next_key hook" do
      @app.expects(:next_key).at_least_once
      
      start_and_stop_app(@app)
    end
    
    it "calls #cleanup hook" do
      @app.expects(:cleanup)
      
      start_and_stop_app(@app)
    end
  end
  
  describe "#stop" do
    before do
      @app.instance_variable_set(:@running, true)
    end
    
    it "sets status not-running" do
      @app.stop
      
      @app.running.must_equal false
    end
  end
  
  describe "#do_command" do
    before do
      @app.instance_variable_set(:@running, true)
    end
    
    it "<q> sets status not-running" do
      @app.do_command(:q)
      
      @app.running.must_equal false
    end
  end
  
end
