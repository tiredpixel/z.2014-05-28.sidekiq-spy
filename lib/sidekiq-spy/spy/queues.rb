require 'sidekiq'
require 'sidekiq/api'


module SidekiqSpy
  module Spy
    class Queues

      include Spy::Dataspyable

      def initialize
        @stats = Sidekiq::Stats.new

        refresh
      end

      def refresh
        h = []

        @stats.queues.each do |queue, size|
          h << {
            :name => queue,
            :size => size,
          }
        end

        @data = h
      end

    end
  end
end
