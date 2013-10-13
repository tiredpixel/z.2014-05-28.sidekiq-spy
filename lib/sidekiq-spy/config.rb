require 'uri'


module SidekiqSpy
  class Config
    
    attr_accessor :host
    attr_accessor :port
    attr_accessor :database
    attr_accessor :namespace
    attr_accessor :interval
    
    def initialize
      @host      = '127.0.0.1'
      @port      = 6379
      @database  = 0
      @namespace = ''
      @interval  = 5
    end
    
    def url=(url)
      url = URI.parse(url)
      
      @host     = url.host unless url.host.empty?
      @port     = url.port unless url.path.empty?
      @database = url.path.tr('/', '').to_i unless url.path.empty?
    end
    
    def url
      "redis://#{@host}:#{@port}/#{@database}"
    end
    
  end
end
