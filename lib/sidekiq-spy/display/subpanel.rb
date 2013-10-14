module SidekiqSpy
  module Display
    class Subpanel
      
      def initialize(window, height, width, top, left, opts = {})
        @window = window
        @height = height
        @width  = width
        @top    = top
        @left   = left
        
        @data = {
          :left  => opts[:data_l],
          :right => opts[:data_r],
        }
        
        @dividers = {
          :left  => opts[:divider_l].to_s,
          :right => opts[:divider_r].to_s,
        }
        
        @content_width = @width - @dividers.values.map(&:length).inject(:+)
      end
      
      def refresh
        new_current = content(@data[:left], @data[:right], @content_width)
        
        unless new_current == @data[:current] # don't redraw if hasn't changed
          @window.setpos(@top, @left)
          @window.addstr(@dividers[:left] + new_current + @dividers[:right])
        end
        
        @data[:current] = new_current
      end
      
      private
      
      def content(data_l, data_r, width)
        l = data_l.is_a?(Proc) ? data_l.call : data_l.to_s
        r = data_r.is_a?(Proc) ? data_r.call : data_r.to_s
        
        l + "%#{width - l.length}s" % r
      end
      
    end
  end
end
