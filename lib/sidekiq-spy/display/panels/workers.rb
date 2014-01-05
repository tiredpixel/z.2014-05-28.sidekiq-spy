module SidekiqSpy
  module Display
    module Panels
      class Workers < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")
          
          @spies[:workers] = Spy::Workers.new
        end
        
        def structure(height)
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          s = [
            [ # table header slots
              [2, t[:heading][:worker], nil],
              [1, t[:heading][:queue],  nil],
              [1, t[:heading][:class],  nil],
              [1, t[:heading][:args],   nil],
              [1, nil,                  t[:heading][:started_at]],
            ],
          ]
          
          (0...(height - 1)).each do |i|
            s << [ # table row slots
              [2, -> { @spies[:workers][i][:name] },  nil],
              [1, -> { @spies[:workers][i][:queue] }, nil],
              [1, -> { @spies[:workers][i][:class] }, nil],
              [1, -> { @spies[:workers][i][:args] },  nil],
              [1, nil,                                -> { @spies[:workers][i][:started_at] }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
