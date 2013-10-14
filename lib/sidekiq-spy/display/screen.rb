require 'curses'


module SidekiqSpy
  module Display
    class Screen
      
      include Translatable
      
      def initialize
        Curses.init_screen
        Curses.nl
        Curses.noecho
        Curses.curs_set(0)
        
        @height = Curses.lines
        @width  = Curses.cols
        
        @panels = {
          :header => panel_header,
        }
      end
      
      def close
        @panels.each { |pname, panel| panel.close }
        
        Curses.close_screen
      end
      
      def refresh
        @panels.each { |pname, panel| panel.refresh }
      end
      
      private
      
      def panel_header
        stats = Spy::Stats.new
        
        structure = [
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
        
        opts = {
          :divider_l => t[:divider][:left],
          :divider_r => t[:divider][:right],
        }
        
        Display::Panel.new(structure.length, @width, 0, 0, structure, opts)
      end
      
    end
  end
end
