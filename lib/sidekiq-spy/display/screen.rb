require 'curses'


module SidekiqSpy
  module Display
    class Screen
      
      def initialize
        Curses.init_screen
        Curses.nl
        Curses.noecho
        Curses.curs_set(0)
        
        @height = Curses.lines
        @width  = Curses.cols
        
        @panels = {
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
