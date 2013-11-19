module SidekiqSpy
  module Display
    module Panels
      class SidekiqStats < Display::Panel
        
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
              [1, t[:sidekiq][:busy],      -> { @spies[:stats][:busy] }],
              [1, t[:sidekiq][:retries],   -> { @spies[:stats][:retries] }],
              [1, t[:sidekiq][:processed], -> { @spies[:stats][:processed] }],
            ],
            [
              [1, t[:sidekiq][:enqueued],  -> { @spies[:stats][:enqueued] }],
              [1, t[:sidekiq][:scheduled], -> { @spies[:stats][:scheduled] }],
              [1, t[:sidekiq][:failed],    -> { @spies[:stats][:failed] }],
            ],
          ]
        end
        
      end
    end
  end
end
