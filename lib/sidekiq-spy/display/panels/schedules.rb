module SidekiqSpy
  module Display
    module Panels
      class Schedules < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")
          
          @spies[:schedules] = Spy::Schedules.new
        end
        
        def structure(height)
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
          
          (0...(height - 1)).each do |i|
            s << [ # table row slots
              [1, -> { @spies[:schedules][i][:scheduled_at] }, nil],
              [1, -> { @spies[:schedules][i][:queue] },        nil],
              [1, -> { @spies[:schedules][i][:class] },        nil],
              [1, nil,                                         -> { @spies[:schedules][i][:args] }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
