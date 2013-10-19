require 'sidekiq'


module SidekiqSpy
  class App
    
    attr_reader :running
    
    def initialize
      @running = false
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
        
        while @running do
          refresh
          
          @sleep_timer = config.interval
          
          while @running && @sleep_timer > 0
            sleep 1
            
            @sleep_timer -= 1
          end
        end
      ensure
        cleanup
      end
    end
    
    def stop
      @running = false
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
    
    def setup
      @screen = Display::Screen.new
    end
    
    def refresh
      @screen.refresh if @screen
    end
    
    def cleanup
      @screen.close if @screen
    end
    
  end
end
