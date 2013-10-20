module SidekiqSpy
  module Display
    module Panels
      class SidekiqStats < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure, :divider_r => "|")
        end
        
        def structure
          stats = Spy::Stats.new
          
          [
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
          ]
        end
        
      end
    end
  end
end
