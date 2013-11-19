module SidekiqSpy
  module Display
    module Panels
      class Queues < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")
        end
        
        def refresh
          @queues.refresh # refresh data feed
          
          super
        end
        
        def structure(height)
          @queues = Spy::Queues.new
          
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
              [2, -> { @queues.data.values[i][:name] rescue nil },  nil],
              [1, nil,                                              -> { @queues.data.values[i][:size] rescue nil }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
