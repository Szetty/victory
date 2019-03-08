require 'containers/deque'
# rdoc
#     A Stack is a container that keeps elements in a last-in first-out (LIFO) order. There are many
#     uses for stacks, including prefix-infix-postfix conversion and backtracking problems.
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
class Containers::Stack
  include Enumerable
  # Create a new stack. Takes an optional array argument to initialize the stack.
  #
  #   s = Containers::Stack.new([1, 2, 3])
  #   s.pop #=> 3
  #   s.pop #=> 2
  def initialize(ary=[])
    @container = Containers::Deque.new(ary)
  end

  # Returns the next item from the stack but does not remove it.
  #
  #   s = Containers::Stack.new([1, 2, 3])
  #   s.next #=> 3
  #   s.size #=> 3
  def next
    @container.back
  end

  # Adds an item to the stack.
  #
  #   s = Containers::Stack.new([1])
  #   s.push(2)
  #   s.pop #=> 2
  #   s.pop #=> 1
  def push(obj)
    @container.push_back(obj)
  end
  alias_method :<<, :push

  # Removes the next item from the stack and returns it.
  #
  #   s = Containers::Stack.new([1, 2, 3])
  #   s.pop #=> 3
  #   s.size #=> 2
  def pop
    @container.pop_back
  end

  # Return the number of items in the stack.
  #
  #   s = Containers::Stack.new([1, 2, 3])
  #   s.size #=> 3
  def size
    @container.size
  end

  # Returns true if the stack is empty, false otherwise.
  def empty?
    @container.empty?
  end

  # Iterate over the Stack in LIFO order.
  def each(&block)
    @container.each_backward(&block)
  end

end