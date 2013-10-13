require 'sidekiq'


module SidekiqSpy
  class App
    
    def config
      @config ||= Config.new
    end
    
    def configure
      yield config
      
      configure_sidekiq
    end
    
    private
    
    def configure_sidekiq
      Sidekiq.configure_client do |sidekiq_config|
        sidekiq_config.redis = {
          :url       => config.url,
          :namespace => config.namespace,
        }
      end
    end
    
  end
end
