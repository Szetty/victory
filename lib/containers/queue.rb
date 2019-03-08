require 'containers/deque'

# rdoc
#     A Queue is a container that keeps elements in a first-in first-out (FIFO) order. Because of its
#     properties, it is often used as a buffer.
#
#     This implementation uses a doubly-linked list, guaranteeing O(1) complexity for all operations.
#
#
#     MIT License
#
#     Copyright (c) 2009 Kanwei Li
#
#     Permission is hereby granted, free of charge, to any person obtaining a copy
#     of this software and associated documentation files (the "Software"), to deal
#     in the Software without restriction, including without limitation the rights
#     to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#     copies of the Software, and to permit persons to whom the Software is
#     furnished to do so, subject to the following conditions:
#
#     The above copyright notice and this permission notice shall be included in all
#     copies or substantial portions of the Software.
#
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#     IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#     LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#     OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#     SOFTWARE.
class Containers::Queue
  include Enumerable
  # Create a new queue. Takes an optional array argument to initialize the queue.
  #
  #   q = Containers::Queue.new([1, 2, 3])
  #   q.pop #=> 1
  #   q.pop #=> 2
  def initialize(ary=[])
    @container = Containers::Deque.new(ary)
  end

  # Returns the next item from the queue but does not remove it.
  #
  #   q = Containers::Queue.new([1, 2, 3])
  #   q.next #=> 1
  #   q.size #=> 3
  def next
    @container.front
  end

  # Adds an item to the queue.
  #
  #   q = Containers::Queue.new([1])
  #   q.push(2)
  #   q.pop #=> 1
  #   q.pop #=> 2
  def push(obj)
    @container.push_back(obj)
  end
  alias_method :<<, :push

  # Removes the next item from the queue and returns it.
  #
  #   q = Containers::Queue.new([1, 2, 3])
  #   q.pop #=> 1
  #   q.size #=> 2
  def pop
    @container.pop_front
  end

  # Return the number of items in the queue.
  #
  #   q = Containers::Queue.new([1, 2, 3])
  #   q.size #=> 3
  def size
    @container.size
  end

  # Returns true if the queue is empty, false otherwise.
  def empty?
    @container.empty?
  end

  # Iterate over the Queue in FIFO order.
  def each(&block)
    @container.each_forward(&block)
  end

end