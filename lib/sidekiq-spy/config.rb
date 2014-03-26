require 'uri'


module SidekiqSpy
  class Config
    
    attr_accessor :username
    attr_accessor :password
    attr_accessor :host
    attr_accessor :port
    attr_accessor :database
    attr_accessor :namespace
    attr_accessor :interval
    
    def initialize
      @username  = nil
      @password  = nil
      @host      = '127.0.0.1'
      @port      = 6379
      @database  = 0
      @namespace = nil
      @interval  = 5
    end
    
    def url=(url)
      url = URI.parse(url)
      
      @username = url.user if url.user && !url.user.empty?
      @password = url.password if url.password && !url.password.empty?
      @host     = url.host unless url.host.empty?
      @port     = url.port if url.port
      @database = url.path.tr('/', '').to_i unless url.path.empty?
    end
    
    def url
      url = URI('')
      
      url.scheme   = 'redis'
      url.user     = @username
      url.password = @password
      url.host     = @host
      url.port     = @port
      url.path     = "/#{@database}"
      
      url.to_s
    end
    
  end
end
