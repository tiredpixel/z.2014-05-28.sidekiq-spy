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
        
        @height = term_height
        @width  = term_width
        
        @panels = { # attach panels, defining height, width, top, left
          :header        => Display::Panels::Header.new(      1, @width, 0, 0),
          :redis_stats   => Display::Panels::RedisStats.new(  3, @width, 1, 0),
          :sidekiq_stats => Display::Panels::SidekiqStats.new(2, @width, 5, 0),
        }
        
        self.panel_main = :workers
        
        Curses.refresh
      rescue
        close
        
        raise
      end
      
      def close
        @panels.each { |pname, panel| panel.close } if @panels
        
        Curses.close_screen
      end
      
      def refresh
        @panels.each { |pname, panel| panel.refresh }
      end
      
      def next_key
        Curses.getch
      end
      
      def missized?
        @height != term_height || @width != term_width
      end
      
      def panel_main
        @panels[:header].panel_main
      end
      
      def panel_main=(pname)
        @panels[:header].panel_main = pname
        
        @panels[:main].close if @panels[:main]
        
        @panels[:main] = case pname
        when :workers
          Display::Panels::Workers.new((@height - 8), @width, 8, 0)
        when :queues
          Display::Panels::Queues.new((@height - 8), @width, 8, 0)
        when :retries
          Display::Panels::Retries.new((@height - 8), @width, 8, 0)
        when :schedules
          Display::Panels::Schedules.new((@height - 8), @width, 8, 0)
        end
      end
      
      private
      
      def term_height
        (ENV['LINES'] || Curses.lines).to_i
      end
      
      def term_width
        (ENV['COLUMNS'] || Curses.cols).to_i
      end
      
    end
  end
end
