require 'minitest/autorun'

require File.expand_path('../../../lib/sidekiq-spy/app', __FILE__)


describe SidekiqSpy::App do
  
  before do
    @app = SidekiqSpy::App.new
  end
  
  it "sets status not-running" do
    @app.running.must_equal false
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
    
    it "stops running within 2s" do
      thread_app = Thread.new { @app.start }
      
      sleep 1 # patience, patience; give app time to start
      
      @app.stop; t0 = Time.now
      
      thread_app.join(3)
      
      Thread.kill(thread_app)
      
      assert_operator (Time.now - t0), :<=, 2
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
  
end
