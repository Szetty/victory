module Containers
  class Tuple
    include Enumerable
    @elements = []
    def self.[](*elements)
      new(elements)
    end

    def initialize(elements)
      @elements = elements
    end

    def [](idx)
      @elements[idx]
    end

    def each(&block)
      @elements.each(&block)
    end

    def to_s
      "(#{@elements.join(',')})"
    end
  end

  T = Tuple
end