require File.expand_path('../../../helper', __FILE__)

require File.expand_path('../../../../lib/sidekiq-spy/display/screen', __FILE__)


module SidekiqSpy
  module Display
    module Panels
      class Header; end
      class RedisStats; end
      class SidekiqStats; end
      class Workers; end
    end
  end
end


describe SidekiqSpy::Display::Screen do
  
  before do
    Object.send(:remove_const, :Curses) if Object.constants.include?(:Curses)
    
    Curses = stub(
      :init_screen  => nil,
      :close_screen => nil,
      :nl           => nil,
      :noecho       => nil,
      :curs_set     => nil,
      :timeout=     => nil,
      :lines        => 24,
      :cols         => 80
    )
    
    @panel = stub(
      :close => nil
    )
    
    SidekiqSpy::Display::Panels::Header.stubs(:new).returns(@panel)
    SidekiqSpy::Display::Panels::RedisStats.stubs(:new).returns(@panel)
    SidekiqSpy::Display::Panels::SidekiqStats.stubs(:new).returns(@panel)
    SidekiqSpy::Display::Panels::Workers.stubs(:new).returns(@panel)
    
    @screen = SidekiqSpy::Display::Screen.new
  end
  
  describe "#initialize" do
    it "inits screen" do
      Curses.expects(:init_screen)
      
      SidekiqSpy::Display::Screen.new
    end
    
    it "sets height" do
      @screen.height.must_equal 24
    end
    
    it "sets width" do
      @screen.width.must_equal 80
    end
  end
  
  describe "#close" do
    it "closes screen" do
      Curses.expects(:close_screen)
      
      @screen.close
    end
    
    it "closes panels" do
      @panel2 = stub
      @panel2.expects(:close)
      
      @screen.instance_variable_set(:@panels, { :panel2 => @panel2 })
      
      @screen.close
    end
  end
  
  describe "#refresh" do
    it "refreshes panels" do
      @panel2 = stub
      @panel2.expects(:refresh)
      
      @screen.instance_variable_set(:@panels, { :panel2 => @panel2 })
      
      @screen.refresh
    end
  end
  
  describe "#next_key" do
    it "gets next key" do
      Curses.expects(:getch)
      
      @screen.next_key
    end
  end
  
end
