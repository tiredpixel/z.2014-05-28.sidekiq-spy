module SidekiqSpy
  class App
    
    def config
      @config ||= Config.new
    end
    
    def configure
      yield config
    end
    
  end
end
