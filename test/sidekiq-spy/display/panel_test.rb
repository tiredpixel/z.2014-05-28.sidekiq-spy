require_relative '../../helper'

require_relative '../../../lib/sidekiq-spy/display/panel'


describe SidekiqSpy::Display::Panel do
  
  before do
    @window = stub
    
    Curses::Window.stubs(:new).returns(@window)
    
    @panel = SidekiqSpy::Display::Panel.new(24, 80, 1, 2)
  end
  
  describe "#initialize" do
    describe "required" do
      it "sets height" do
        @panel.height.must_equal 24
      end
      
      it "sets width" do
        @panel.width.must_equal 80
      end
      
      it "sets top" do
        @panel.top.must_equal 1
      end
      
      it "sets left" do
        @panel.left.must_equal 2
      end
      
      it "defaults dividers" do
        @panel.dividers.must_equal({
          :left  => '',
          :right => '',
        })
      end
      
      it "calculates divider_length" do
        @panel.divider_length.must_equal 0
      end
      
      it "sets up window with dimensions" do
        Curses::Window.expects(:new).with(24, 80, 1, 2)
        
        SidekiqSpy::Display::Panel.new(24, 80, 1, 2)
      end
      
      it "sets window" do
        @panel.instance_variable_get(:@window).must_equal @window
      end
    end
    
    describe "optional" do
      before do
        @structure = [
          [
            [1, "busy:",    -> { 1 + 3 }], # S(0,0)
            [1, "retries:", 2],  # S(0,1)
          ],
          [
            [2, -> { 2 * 7 },     "long"],  # S(1,0)
            [1, -> { "1" + "4" }, -> { "dark" }], # S(1,1)
          ],
        ]
        
        @panel = SidekiqSpy::Display::Panel.new(24, 80, 1, 2, @structure,
          :divider_l => '<',
          :divider_r => '>'
        )
        
        @subpanels = @panel.instance_variable_get(:@subpanels)
      end
      
      it "sets dividers" do
        @panel.dividers.must_equal({
          :left  => '<',
          :right => '>',
        })
      end
      
      it "calculates divider_length" do
        @panel.divider_length.must_equal 2
      end
      
      it "builds enough subpanels" do
        @subpanels.length.must_equal 4
      end
      
      it "builds S(0,0)" do
        @subpanels.count { |e|
          e.height == 1 && e.width == 42 && e.top == 0 && e.left == 0 &&
          e.data[:left] == "busy:" && e.data[:right].call == 4 &&
          e.dividers[:left] == '' && e.dividers[:right] == '>' &&
          e.content_width == 41
        }.must_equal 1
      end
      
      it "builds S(0,1)" do
        @subpanels.count { |e|
          e.height == 1 && e.width == 38 && e.top == 0 && e.left == 42 &&
          e.data[:left] == "retries:" && e.data[:right] == 2 &&
          e.dividers[:left] == '<' && e.dividers[:right] == '' &&
          e.content_width == 37
        }.must_equal 1
      end
      
      it "builds S(1,0)" do
        @subpanels.count { |e|
          e.height == 1 && e.width == 56 && e.top == 1 && e.left == 0 &&
          e.data[:left].call == 14 && e.data[:right] == "long" &&
          e.dividers[:left] == '' && e.dividers[:right] == '>' &&
          e.content_width == 55
        }.must_equal 1
      end
      
      it "builds S(1,1)" do
        @subpanels.count { |e|
          e.height == 1 && e.width == 24 && e.top == 1 && e.left == 56 &&
          e.data[:left].call == "14" && e.data[:right].call == "dark" &&
          e.dividers[:left] == '<' && e.dividers[:right] == '' &&
          e.content_width == 23
        }.must_equal 1
      end
    end
  end
  
  describe "#close" do
    it "closes window" do
      @window.expects(:close)
      
      @panel.close
    end
  end
  
  describe "#refresh" do
    it "refreshes subpanels" do
      @window.stubs(:refresh)
      
      @subpanel2 = stub
      @subpanel2.expects(:refresh)
      
      @panel.instance_variable_set(:@subpanels, [@subpanel2])
      
      @panel.refresh
    end
    
    it "refreshes window" do
      @subpanel2 = stub(:refresh => nil)
      
      @panel.instance_variable_set(:@subpanels, [@subpanel2])
      
      @window.expects(:refresh)
      
      @panel.refresh
    end
  end
  
end
