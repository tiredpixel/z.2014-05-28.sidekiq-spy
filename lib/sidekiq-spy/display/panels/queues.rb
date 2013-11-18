module SidekiqSpy
  module Display
    module Panels
      class Queues < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure, :divider_r => " ")
        end
        
        def structure
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          []
        end
        
      end
    end
  end
end
