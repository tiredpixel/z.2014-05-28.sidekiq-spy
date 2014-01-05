module SidekiqSpy
  module Display
    module Panels
      class Retries < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")
          
          @spies[:retries] = Spy::Retries.new
        end
        
        def structure(height)
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
          
          (0...(height - 1)).each do |i|
            s << [ # table row slots
              [1, -> { @spies[:retries][i][:next_at] }, nil],
              [1, -> { @spies[:retries][i][:count] },   nil],
              [1, -> { @spies[:retries][i][:queue] },   nil],
              [1, -> { @spies[:retries][i][:class] },   nil],
              [1, -> { @spies[:retries][i][:args] },    nil],
              [1, nil,                                  -> { @spies[:retries][i][:error_class] }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
