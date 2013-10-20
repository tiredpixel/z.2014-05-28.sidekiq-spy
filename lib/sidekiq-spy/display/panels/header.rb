module SidekiqSpy
  module Display
    module Panels
      class Header < Display::Panel
        
        def initialize(height, width, top, left)
          opts = {
            :divider_l => t[:divider][:left],
            :divider_r => t[:divider][:right],
          }
          
          super(height, width, top, left, structure, opts)
        end
        
        def structure
          stats = Spy::Stats.new
          
          [
            [
              [1, t[:program], nil],
              [1, nil,         -> { Time.now.strftime("%T %z") }],
            ],
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
            nil,
            [
              [1, t[:sidekiq][:busy],      -> { stats.busy }],
              [1, t[:sidekiq][:retries],   -> { stats.retries }],
              [1, t[:sidekiq][:processed], -> { stats.processed }],
            ],
            [
              [1, t[:sidekiq][:enqueued],  -> { stats.enqueued }],
              [1, t[:sidekiq][:scheduled], -> { stats.scheduled }],
              [1, t[:sidekiq][:failed],    -> { stats.failed }],
            ],
            nil,
          ]
        end
        
      end
    end
  end
end
