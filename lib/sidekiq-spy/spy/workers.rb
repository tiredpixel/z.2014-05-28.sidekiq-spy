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

        @workers.each do |process_id, thread_id, work|
          h << {
              :name => process_id,
              :queue => work['queue'],
              :class => work['payload']['class'],
              :args => work['payload']['args'],
              :started_at => (work['run_at'].is_a?(Numeric) ? Time.at(work['run_at']) : Time.parse(work['run_at'])),
          }
        end
        @data = h
      end

    end
  end
end
