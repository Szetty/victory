class Tuple
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

  def to_a
    @elements.to_a
  end
end

T = Tuple