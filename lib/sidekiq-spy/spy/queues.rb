require 'sidekiq'


module SidekiqSpy
  module Spy
    class Queues
      
      attr_reader :data
      
      def initialize
        @stats = Sidekiq::Stats.new
        
        refresh
      end
      
      def refresh
        h = {}
        
        @stats.queues.each do |queue, size|
          h[queue] = {
            :name => queue,
            :size => size,
          }
        end
        
        @data = h
      end
      
    end
  end
end
