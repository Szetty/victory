require 'containers/list'

class PrefixTree
  class Node
    attr_accessor :data, :children

    def initialize
      @data = nil
      @children = {}
    end
  end

  def initialize
    @root = Node.new
  end

  def <<(str, value = true)
    insert(str, value)
  end

  def insert(str, value = true)
    current = @root
    str.each_char do |c|
      current.children[c] = Node.new if current.children[c].nil?
      current = current.children[c]
    end
    current.data = value
  end

  def [](str)
    find(str)
  end

  def find(str)
    current = @root
    str.each_char do |c|
      return nil if current.children[c].nil?

      current = current.children[c]
    end
    current.data
  end

  def count_partial(str)
    current = @root
    str.each_char do |c|
      return 0 if current.children[c].nil?

      current = current.children[c]
    end
    stack = List.new
    count = 0
    current.children.each_value(&stack.method(:push))
    until stack.empty?
      current = stack.pop
      count += 1 unless current.data.nil?
      current.children.each_value(&stack.method(:push))
    end
    count
  end
end