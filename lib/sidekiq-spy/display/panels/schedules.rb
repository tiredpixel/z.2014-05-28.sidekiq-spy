module SidekiqSpy
  module Display
    module Panels
      class Schedules < Display::Panel
        
        def initialize(height, width, top, left)
          @height = height # #structure needs this before #initialize ends
          
          super(height, width, top, left, structure, :divider_r => " ")
        end
        
        def refresh
          @schedules.refresh # refresh data feed
          
          super
        end
        
        def structure
          @schedules = Spy::Schedules.new
          
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          s = [
            [ # table header slots
              [1, t[:heading][:scheduled_at], nil],
              [1, t[:heading][:queue],        nil],
              [1, t[:heading][:class],        nil],
              [1, nil,                        t[:heading][:args]],
            ],
          ]
          
          (0...(@height - 1)).each do |i|
            s << [ # table row slots
              [1, -> { @schedules.data[i][:scheduled_at] rescue nil }, nil],
              [1, -> { @schedules.data[i][:queue] rescue nil },        nil],
              [1, -> { @schedules.data[i][:class] rescue nil },        nil],
              [1, nil,                                                 -> { @schedules.data[i][:args] rescue nil }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
