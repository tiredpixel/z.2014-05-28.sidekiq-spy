module SidekiqSpy
  module Spy
    module Dataspyable
      
      include Enumerable
      
      def each(&block)
        @data.each(&block)
      end
      
      def [](key)
        @data[key] || {}
      end
      
    end
  end
end
