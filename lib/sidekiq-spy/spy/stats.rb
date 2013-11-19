require 'sidekiq'


module SidekiqSpy
  module Spy
    class Stats
      
      include Spy::Dataspyable
      
      def initialize
        @stats   = Sidekiq::Stats.new
        @workers = Sidekiq::Workers.new
        
        refresh
      end
      
      def refresh
        h = {}
        
        redis do |c|
          h.merge!({
            :connection    => "#{c.client.location}/#{c.client.db}",
            :namespace     => (c.respond_to?(:namespace) ? c.namespace : ""),
            :redis_version => c.info['redis_version'],
            :uptime        => c.info['uptime_in_days'],
            :connections   => c.info['connected_clients'],
            :memory        => c.info['used_memory_human'],
            :memory_peak   => c.info['used_memory_peak_human'],
          })
        end
        
        h.merge!({
          :busy      => @workers.size,
          :enqueued  => @stats.enqueued,
          :retries   => @stats.retry_size,
          :scheduled => @stats.scheduled_size,
          :processed => @stats.processed,
          :failed    => @stats.failed,
        })
        
        @data = h
      end
      
      private
      
      def redis
        Sidekiq.redis { |c| yield c }
      end
      
    end
  end
end
