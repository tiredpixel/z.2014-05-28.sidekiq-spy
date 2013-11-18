module SidekiqSpy
  module Display
    module Panels
      class Header < Display::Panel
        
        attr_accessor :panel_main
        
        def initialize(height, width, top, left)
          super(height, width, top, left, structure, :divider_r => " ")
        end
        
        def structure
          @panel_main = nil # set by Display::Screen#main_panel=
          
          # [
          #   [relative_column_width, data_left, data_right]
          # ]
          [
            [
              [1, t[:program], nil],
              [2, -> {
                [:workers, :queues, :retries, :schedules].map do |e|
                  t[:menu][(e == @panel_main ? :active : :inactive)][e]
                end.join(" ")
              }, nil],
              [1, nil, -> { Time.now.strftime("%T %z") }],
            ],
          ]
        end
        
      end
    end
  end
end
