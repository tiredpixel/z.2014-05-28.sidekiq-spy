require 'curses'


module SidekiqSpy
  module Display
    class Panel
      
      include Translatable
      
      attr_reader :height
      attr_reader :width
      attr_reader :top
      attr_reader :left
      attr_reader :dividers
      attr_reader :divider_length
      
      def initialize(height, width, top, left, structure = [], opts = {})
        @height = height
        @width  = width
        @top    = top
        @left   = left
        
        @dividers = {
          :left  => opts[:divider_l].to_s,
          :right => opts[:divider_r].to_s,
        }
        
        @divider_length = @dividers.values.map(&:length).inject(:+)
        
        @window = Curses::Window.new(@height, @width, @top, @left)
        
        @subpanels = build_subpanels(structure)
      end
      
      def close
        @window.close
      end
      
      def refresh
        @subpanels.each(&:refresh) # build changes 
        
        @window.refresh # push changes to window
      end
      
      private
      
      def build_subpanels(structure)
        subpanels = []
        
        structure.each_with_index do |row, i|
          next if row.nil? # skip blank rows
          
          row_cols = row.map { |e| e[0] }.inject(:+)
          
          col_width = (@width / row_cols) + @divider_length
          
          col_i = 0
          
          row.each_with_index do |(tag_cols, data_l, data_r), row_i|
            first_col = row_i == 0
            last_col  = row_i + 1 == row.length
            
            tag_col_width = if last_col
              @width - ((row_cols - tag_cols) * col_width)
            else
              tag_cols * col_width
            end
            
            subpanels << Display::Subpanel.new(
              @window,
              1,
              tag_col_width,
              i,
              col_i,
              :data_l    => data_l,
              :data_r    => data_r,
              :divider_l => (@dividers[:left] unless first_col),
              :divider_r => (@dividers[:right] unless last_col)
            )
            
            col_i += tag_col_width
          end
        end
        
        subpanels
      end
      
    end
  end
end
