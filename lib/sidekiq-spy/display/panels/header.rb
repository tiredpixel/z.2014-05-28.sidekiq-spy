module SidekiqSpy
  module Display
    module Panels
      class Header < Display::Panel
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure)
        end
        
        def structure
          stats = Spy::Stats.new
          
          [
            [
              [1, t[:program], nil],
              [1, nil,         -> { Time.now.strftime("%T %z") }],
            ],
          ]
        end
        
      end
    end
  end
end
