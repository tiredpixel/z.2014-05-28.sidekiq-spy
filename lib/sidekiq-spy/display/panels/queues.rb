module SidekiqSpy
  module Display
    module Panels
      class Queues < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")
          
          @spies[:queues] = Spy::Queues.new
        end
        
        def structure(height)
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          s = [
            [ # table header slots
              [2, t[:heading][:queue],  nil],
              [1, nil,                  t[:heading][:size]],
            ],
          ]
          
          (0...(height - 1)).each do |i|
            s << [ # table row slots
              [2, -> { @spies[:queues][i][:name] }, nil],
              [1, nil,                              -> { @spies[:queues][i][:size] }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
