require 'curses'


module SidekiqSpy
  module Display
    class Screen
      
      attr_reader :height
      attr_reader :width
      
      def initialize
        Curses.init_screen
        Curses.nl
        Curses.noecho
        Curses.curs_set(0)
        
        @height = Curses.lines
        @width  = Curses.cols
        
        @panels = { # attach panels, defining height, width, top, left
          :header        => Display::Panels::Header.new(      1, @width, 0, 0),
          :redis_stats   => Display::Panels::RedisStats.new(  3, @width, 1, 0),
          :sidekiq_stats => Display::Panels::SidekiqStats.new(2, @width, 5, 0),
        }
      end
      
      def close
        @panels.each { |pname, panel| panel.close }
        
        Curses.close_screen
      end
      
      def refresh
        @panels.each { |pname, panel| panel.refresh }
      end
      
    end
  end
end
