require 'sidekiq'


module SidekiqSpy
  module Spy
    class Retries
      
      attr_reader :data
      
      def initialize
        @retries = Sidekiq::RetrySet.new
        
        refresh
      end
      
      def refresh
        h = []
        
        @retries.each do |retry_item|
          h << {
            :next_at       => retry_item.at,
            :count         => retry_item['retry_count'],
            :queue         => retry_item['queue'],
            :class         => retry_item['class'],
            :args          => retry_item['args'],
            :error_class   => retry_item['error_class'],
            :error_message => retry_item['error_message'],
          }
        end
        
        @data = h
      end
      
    end
  end
end
