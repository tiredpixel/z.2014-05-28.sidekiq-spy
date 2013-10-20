module SidekiqSpy
  module Display
    module Panels
      class RedisStats < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure, :divider_r => "|")
        end
        
        def structure
          stats = Spy::Stats.new
          
          [
            [
              [2, t[:redis][:connection], -> { stats.connection }],
              [1, t[:redis][:namespace],  -> { stats.namespace }],
            ],
            [
              [1, t[:redis][:version],     -> { stats.redis_version }],
              [1, t[:redis][:uptime],      -> { stats.uptime }],
              [1, t[:redis][:connections], -> { stats.connections }],
            ],
            [
              [1, t[:redis][:memory],      -> { stats.memory }],
              [1, t[:redis][:memory_peak], -> { stats.memory_peak }],
              [1, nil,                     nil],
            ],
          ]
        end
        
      end
    end
  end
end
