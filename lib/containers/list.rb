class List
  Node = Struct.new(:data, :prev, :next)
  def initialize
    @first = nil
    @last = nil
  end

  def self.[](*arr)
    from_a(arr)
  end

  def self.from_a(arr)
    l = new
    arr.each(&l.method(:push_front))
    l
  end

  def empty?
    @first == @last && @first.nil?
  end

  def push_front(element)
    node = Node.new(element, nil, @first)
    if @first.nil?
      @last = node
    else
      @first.prev = node
    end
    @first = node
  end

  def pop_front
    to_return = @first&.data
    unless @first.nil?
      @first = @first.next
      if @first.nil?
        @last = nil
      else
        @first.prev = nil unless @first.nil?
      end
    end
    to_return
  end

  def push_back(element)
    node = Node.new(element, @last, nil)
    if @last.nil?
      @first = node
    else
      @last.next = node
    end
    @last = node
  end

  def pop_back
    to_return = @last&.data
    unless @last.nil?
      @last = @last.prev
      if @last.nil?
        @first = nil
      else
        @last.next = nil unless @last.nil?
      end
    end
    to_return
  end

  def peek_front
    @first&.data
  end

  def peek_back
    @last&.data
  end

  alias push push_back
  alias pop pop_back
  alias unshift push_front
  alias shift pop_front
end
L = List