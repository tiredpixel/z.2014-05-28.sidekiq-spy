require 'sidekiq'


module SidekiqSpy
  module Spy
    class Stats
      
      def initialize(opts = {})
        @sidekiq = opts[:sidekiq] || Sidekiq
        @stats   = opts[:sidekiq_stats] || Sidekiq::Stats.new
        @workers = opts[:sidekiq_workers] || Sidekiq::Workers.new
      end
      
      def connection
        redis { |c| "#{c.client.location}/#{c.client.db}" }
      end
      
      def namespace
        redis { |c| c.namespace if c.respond_to?(:namespace) }
      end
      
      def redis_version
        redis { |c| c.info['redis_version'] }
      end
      
      def uptime
        redis { |c| c.info['uptime_in_days'] }
      end
      
      def connections
        redis { |c| c.info['connected_clients'] }
      end
      
      def memory
        redis { |c| c.info['used_memory_human'] }
      end
      
      def memory_peak
        redis { |c| c.info['used_memory_peak_human'] }
      end
      
      def busy
        @workers.size
      end
      
      def enqueued
        @stats.enqueued
      end
      
      def retries
        @stats.retry_size
      end
      
      def scheduled
        @stats.scheduled_size
      end
      
      def processed
        @stats.processed
      end
      
      def failed
        @stats.failed
      end
      
      # private
      
      def redis
        @sidekiq.redis { |c| yield c }
      end
      
    end
  end
end
