require 'thread'
require 'sidekiq'


module SidekiqSpy
  class App
    
    REFRESH_SUBINTERVAL = 0.1
    
    attr_reader :running
    attr_reader :restarting
    
    def initialize
      @running    = false
      @restarting = false
      @threads    = {}
    end
    
    def config
      @config ||= Config.new
    end
    
    def configure
      yield config
      
      configure_sidekiq
    end
    
    def start
      begin
        @running = true
        
        setup
        
        @threads[:command] ||= Thread.new do
          command_loop # listen for commands
        end
        
        @threads[:refresh] ||= Thread.new do
          refresh_loop # refresh frequently
        end
        
        @threads.each { |tname, t| t.join }
      ensure
        cleanup
      end
    end
    
    def stop
      @running = false
    end
    
    def restart
      @restarting = true
    end
    
    def do_command(key)
      case key
      when 'q' # quit
        @running = false
      end
    end
    
    private
    
    def configure_sidekiq
      Sidekiq.configure_client do |sidekiq_config|
        sidekiq_config.logger = nil
        sidekiq_config.redis = {
          :url       => config.url,
          :namespace => config.namespace,
        }
      end
    end
    
    def command_loop
      while @running do
        key = next_key
        
        next unless key # keep listening if timeout
        
        do_command(key)
      end
    end
    
    def refresh_loop
      while @running do
        if @restarting || missized? # signal(s) or whilst still resizing
          cleanup
          
          setup
          
          @restarting = false
        end
        
        refresh
        
        @sleep_timer = config.interval
        
        while @running && @sleep_timer > 0
          sleep REFRESH_SUBINTERVAL
          
          @sleep_timer -= REFRESH_SUBINTERVAL
        end
      end
    end
    
    def setup
      @screen = Display::Screen.new
    end
    
    def refresh
      @screen.refresh if @screen
    end
    
    def next_key
      @screen.next_key if @screen
    end
    
    def missized?
      @screen.missized? if @screen
    end
    
    def cleanup
      @screen.close if @screen
    end
    
  end
end
