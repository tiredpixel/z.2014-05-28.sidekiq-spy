require 'sidekiq'


module SidekiqSpy
  module Spy
    class Schedules
      
      attr_reader :data
      
      def initialize
        @schedules = Sidekiq::ScheduledSet.new
        
        refresh
      end
      
      def refresh
        h = []
        
        @schedules.each do |schedule|
          h << {
            :scheduled_at => schedule.at,
            :queue        => schedule['queue'],
            :class        => schedule['class'],
            :args         => schedule['args'],
          }
        end
        
        @data = h
      end
      
    end
  end
end
