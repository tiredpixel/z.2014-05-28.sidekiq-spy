require 'time'
require 'sidekiq'


module SidekiqSpy
  module Spy
    class Workers
      
      include Spy::Dataspyable
      
      def initialize
        @workers = Sidekiq::Workers.new
        
        refresh
      end
      
      def refresh
        h = []
        
        @workers.each do |worker, msg|
          h << {
            :name       => worker,
            :queue      => msg['queue'],
            :class      => msg['payload']['class'],
            :args       => msg['payload']['args'],
            :started_at => (msg['run_at'].is_a?(Numeric) ? Time.at(msg['run_at']) : Time.parse(msg['run_at'])),
          }
        end
        
        @data = h
      end
      
    end
  end
end
