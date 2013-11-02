require 'curses'


module SidekiqSpy
  module Display
    class Screen
      
      CURSES_GETCH_TIMEOUT = 100
      
      attr_reader :height
      attr_reader :width
      
      def initialize
        Curses.init_screen
        Curses.nl
        Curses.noecho
        Curses.curs_set(0)
        Curses.timeout = CURSES_GETCH_TIMEOUT
        
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
      
      def next_key
        Curses.getch
      end
      
    end
  end
end
