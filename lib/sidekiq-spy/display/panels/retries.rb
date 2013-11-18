module SidekiqSpy
  module Display
    module Panels
      class Retries < Display::Panel
        
        def initialize(height, width, top, left)
          @height = height # #structure needs this before #initialize ends
          
          super(height, width, top, left, structure, :divider_r => " ")
        end
        
        def refresh
          @retries.refresh # refresh data feed
          
          super
        end
        
        def structure
          @retries = Spy::Retries.new
          
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          s = [
            [ # table header slots
              [1, t[:heading][:next_at], nil],
              [1, t[:heading][:count],   nil],
              [1, t[:heading][:queue],   nil],
              [1, t[:heading][:class],   nil],
              [1, t[:heading][:args],    nil],
              [1, nil,                   t[:heading][:error]],
            ],
          ]
          
          (0...(@height - 1)).each do |i|
            s << [ # table row slots
              [1, -> { @retries.data[i][:next_at] rescue nil }, nil],
              [1, -> { @retries.data[i][:count] rescue nil },   nil],
              [1, -> { @retries.data[i][:queue] rescue nil },   nil],
              [1, -> { @retries.data[i][:class] rescue nil },   nil],
              [1, -> { @retries.data[i][:args] rescue nil },    nil],
              [1, nil,                                          -> { @retries.data[i][:error_class] rescue nil }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
