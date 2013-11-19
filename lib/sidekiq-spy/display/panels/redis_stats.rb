module SidekiqSpy
  module Display
    module Panels
      class RedisStats < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure, :divider_r => "|")
          
          @spies[:stats] = Spy::Stats.new
        end
        
        def structure
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          [
            [
              [2, t[:redis][:connection], -> { @spies[:stats][:connection] }],
              [1, t[:redis][:namespace],  -> { @spies[:stats][:namespace] }],
            ],
            [
              [1, t[:redis][:version],     -> { @spies[:stats][:redis_version] }],
              [1, t[:redis][:uptime],      -> { @spies[:stats][:uptime] }],
              [1, t[:redis][:connections], -> { @spies[:stats][:connections] }],
            ],
            [
              [1, t[:redis][:memory],      -> { @spies[:stats][:memory] }],
              [1, t[:redis][:memory_peak], -> { @spies[:stats][:memory_peak] }],
              [1, nil,                     nil],
            ],
          ]
        end
        
      end
    end
  end
end
