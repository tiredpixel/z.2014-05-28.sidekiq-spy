module SidekiqSpy
  module Display
    module Panels
      class Workers < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure(height), :divider_r => " ")
        end
        
        def refresh
          @workers.refresh # refresh data feed
          
          super
        end
        
        def structure(height)
          @workers = Spy::Workers.new
          
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
              [2, -> { @workers.data.values[i][:name] rescue nil },  nil],
              [1, -> { @workers.data.values[i][:queue] rescue nil }, nil],
              [1, -> { @workers.data.values[i][:class] rescue nil }, nil],
              [1, -> { @workers.data.values[i][:args] rescue nil },  nil],
              [1, nil,                                               -> { @workers.data.values[i][:started_at] rescue nil }],
            ]
          end
          
          s
        end
        
      end
    end
  end
end
