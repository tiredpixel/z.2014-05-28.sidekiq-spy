require File.expand_path('../../../helper', __FILE__)

require File.expand_path('../../../../lib/sidekiq-spy/display/subpanel', __FILE__)


describe SidekiqSpy::Display::Subpanel do
  
  describe "#initialize" do
    describe "required" do
      before do
        @window = stub
        
        @subpanel = SidekiqSpy::Display::Subpanel.new(@window, 24, 80, 1, 2)
      end
      
      it "sets window" do
        @subpanel.instance_variable_get(:@window).must_equal @window
      end
      
      it "sets height" do
        @subpanel.instance_variable_get(:@height).must_equal 24
      end
      
      it "sets width" do
        @subpanel.instance_variable_get(:@width).must_equal 80
      end
      
      it "sets top" do
        @subpanel.instance_variable_get(:@top).must_equal 1
      end
      
      it "sets left" do
        @subpanel.instance_variable_get(:@left).must_equal 2
      end
      
      it "defaults data" do
        @subpanel.instance_variable_get(:@data).must_equal({
          :left  => '',
          :right => '',
        })
      end
      
      it "defaults dividers" do
        @subpanel.instance_variable_get(:@dividers).must_equal({
          :left  => '',
          :right => '',
        })
      end
      
      it "calculates content_width" do
        @subpanel.instance_variable_get(:@content_width).must_equal 80
      end
    end
    
    describe "optional" do
      before do
        @subpanel = SidekiqSpy::Display::Subpanel.new(stub, 24, 80, 1, 2, {
          :data_l    => 'key:',
          :data_r    => 'value',
          :divider_l => '<',
          :divider_r => '/>',
        })
      end
      
      it "sets data" do
        @subpanel.instance_variable_get(:@data).must_equal({
          :left  => 'key:',
          :right => 'value',
        })
      end
      
      it "sets dividers" do
        @subpanel.instance_variable_get(:@dividers).must_equal({
          :left  => '<',
          :right => '/>',
        })
      end
      
      it "calculates content_width" do
        @subpanel.instance_variable_get(:@content_width).must_equal 77
      end
    end
  end
  
  describe "#refresh" do
    describe "strings and dividers" do
      before do
        @window = stub
        
        @subpanel = SidekiqSpy::Display::Subpanel.new(@window, 24, 80, 1, 2, {
          :data_l    => 'key:',
          :data_r    => 'value',
          :divider_l => '<-',
          :divider_r => '|',
        })
      end
      
      describe "when changed" do
        it "sets position" do
          @window.stubs(:addstr)
          
          @window.expects(:setpos).with(1, 2)
          
          @subpanel.refresh
        end
        
        it "sets data" do
          @window.stubs(:setpos)
          
          @window.expects(:addstr).with("<-key:                                                                    value|")
          
          @subpanel.refresh
        end
      end
      
      describe "when unchanged" do
        before do
          @window.stubs(:setpos)
          @window.stubs(:addstr)
          
          @subpanel.refresh
        end
        
        it "skips position" do
          @window.expects(:setpos).never
          
          @subpanel.refresh
        end
        
        it "skips data" do
          @window.expects(:addstr).never
          
          @subpanel.refresh
        end
      end
    end
    
    describe "lambdas" do
      before do
        @window = stub
        
        @subpanel = SidekiqSpy::Display::Subpanel.new(@window, 24, 80, 0, 0, {
          :data_l => -> { "the answer:" },
          :data_r => -> { 2 * 3 * 7 }
        })
      end
      
      it "sets data when changed" do
        @window.stubs(:setpos)
        
        @window.expects(:addstr).with("the answer:                                                                   42")
        
        @subpanel.refresh
      end
    end
  end
  
end
