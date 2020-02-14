# Usage

In this markdown you will see the usage of all the datastructures and algorithms available through the standard library and this gem.

For them to work you firstly need to require the library with `require 'victory'`.

# Data Structures

* [Ranges and Loops](#ranges)
* [Complex](#complex)
* [Array](#array)
* [Hash](#hash)
* [Struct](#struct)
* [Matrix](#matrix)
* [Set](#set)
* [OpenStruct](#openstruct)
* [Tuple](#tuple)
* [Graph](#graph)
* [IOHelpers](#io-helpers)
* [Concurrent Structures](#concurrent)

<a name="ranges" />

## Ranges and loops

```ruby
5.times { |x| puts x } # displays numbers from 0 to 5
3.upto(7) { |x| puts x } # displays numbers from 3 to 7
5.downto(3) { |x| puts x } # displays numbers from 5 to 3
0.step(10, 2) { |x| puts x } # displays 0, 2, 4, 6, 8, 10
12.step(6, -2) { |x| puts x } # displays 12, 10, 8, 6
(0...1).step(0.1) { |x| puts x } # displays 0.0, 0.1, ... , 0.8, 0.9
loop { |x| puts x } # infinite loop
```

<a name="complex" />

## Complex

```ruby
a = 1+2i
# => (1+2i)
a.real
# => 1
a.imag
# => 2
a.rect
# => [1, 2]
r, i = a.rect
r + i.i
# => (1+2i)
```

<a name="array" />

## Array

```ruby
[]
# => []
Array.new(4)
# => [nil, nil, nil, nil]
Array.new(4, 4)
# => [4, 4, 4, 4]
  
a = [:a, :b, :c, :d]
a[2]
# => :c
a[1] = 3
a
# => [:a, 3, :c, :d]

b = [1,2,3]
b[10] = :foo
b
# => [1, 2, 3, nil, nil, nil, nil, nil, nil, nil, :foo]
```

<a name="hash" />

## Hash 

```ruby
{}
Hash.new(default = nil)
# => {}
{"a" => 100, "b" => 200}
# => {"a"=>100, "b"=>200}
{a: 100, b: 200}
# => {:a=>100, :b=>200}
a = {}
a[1] = 2
a
# => {1=>2}
a[1]
# => 2 
```

<a name="struct" />

## Struct

```ruby
Face = Struct.new(:hair, :eyes, :skin)

my_face = Face.new :blond, :blue, :awesome
# => #<struct Face hair=:blond, eyes=:blue, skin=:awesome>

my_face[:hair]
# => :blond 
my_face.hair
# => :blond 
my_face.nose
# NoMethodError: undefined method `nose' for #<struct Face hair=:blond, eyes=:blue, skin=:awesome>
my_face[:nose]
# NameError: no member 'nose' in struct
 

class PayChecks < Struct.new(:week1, :week2, :week3, :week4)
  def total
    inject :+
  end
end

pay_checks = PayChecks.new 100, 800, 300, 45
# => #<struct PayChecks week1=100, week2=800, week3=300, week4=45> 
pay_checks.total
# => 1245 
```

For the following data structures you will need to include `Containers` or prefix every container with it.

<a name="matrix" />

## Matrix

```ruby
m = Matrix[[1, 2, 3], [3, 4, 5], [6, 7, 8]]
# => Matrix[[1, 2, 3], [3, 4, 5], [6, 7, 8]]
m[0,0]
# => 1
m[1,1]
# => 4
m.row(2)
# => Vector[6, 7, 8]
m.column(1)
# => Vector[2, 4, 7]
```

<a name="set" />

## Set 

```ruby
s = Set.new
# => #<Set: {}> 
s << :a
# => #<Set: {:a}> 
s << :a
# => #<Set: {:a}> 
s << :b
# => #<Set: {:a, :b}> 
```

<a name="openstruct" />

## OpenStruct

```ruby
x = OpenStruct.new
# => #<OpenStruct> 

x[:a]
# => nil 
x
# => #<OpenStruct> 

x[:a] = 0
# => 0 
x
# => #<OpenStruct a=0> 
x.a
# => 0 

x.b
# => nil 
x
# => #<OpenStruct a=0> 
x[:b]  = 123
# => 123 
x
# => #<OpenStruct a=0, b=123>
``` 

<a name="tuple" />

## Tuple

```ruby
t = T[1, 2, 3]

a, _, c = *t
a
# => 1
c
# => 3
t[2]
# => 2
```

<a name="bitset" />

## Bitset

From [Bitset](https://github.com/ericboesch/bitset):

You create a bitset like this:

    >> Bitset.new(8)
    => 00000000

Here we created an 8-bit bitset. All bits are initialized to 0.

We can also create a bitset based on a string of ones and zeros.

    >> Bitset.from_s('00010001')
    => 00010001

or from an array. Falsey values (false and nil) are converted to
zeroes; all other values, including 0 and "", are converted to ones.

    >> Bitset.new [false, nil, 3, 0]
    => 0011

To input an array of ones and zeroes:

    >> Bitset.new([0,1,1,0].map(&:positive?))
    => 0110

Obviously you can also set and clear bits...

    >> bitset = Bitset.new(8)
    => 00000000

    >> bitset[3] = true
    => 00010000

    >> bitset[3] = false
    => 00000000

    >> bitset.set(1, 3, 5, 7)
    => 01010101

    >> bitset.clear(1, 5)
    => 00010001

Arrays of Integers can also be passed to #clear and #set (c/o brendon9x).

The point of a bitset is to be, effectively, an array of single bits. It should
support basic set and bitwise operations. So, let's look at a few of those.

    >> a = Bitset.from_s('00001111')
    => 00001111

    >> b = Bitset.from_s('01010101')
    => 01010101

    >> a & b
    => 00000101

    >> a | b
    => 01011111

    >> b - a
    => 01010000

    >> a ^ b
    => 01011010

    >> ~a
    => 11110000

    >> a.hamming(b)
    => 4

    >> a.cardinality
    => 4

    >> a.reverse
    => 11110000

    # Tell whether all of the given bit numbers are set
    >> a.set? 6
    => true

    # Return a new Bitset composed of bits #1, #3, #5, #4, and #1
    # again. Unlike Array#values_at, this function currently only
    # accepts an array of Fixnums as its argument.
    >> a.values_at [1,3,5,4,1]
    => 00110

    # Tell whether all of the given bit numbers are clear
    >> a.clear? 1,3,5
    => false

    # Tell whether all bits are clear
    >> a.empty?
    => false

    # Pass all bits to the block
    >> b.each { |v| puts v }
    => false
       true
       false
       ...

    # Pass the positions of all set bits to the block
    >> b.each_set { |bit| puts bit }
    => 1
       3
       5
       7

    # Return an array of the positions of all set bits
    >> b.each_set      # AKA b.to_a
    => [1, 3, 5, 7]

    # b.each_set(index) == b.each_set[index], but faster.
    >> b.each_set(-3) # Negative index wraps around.
    => 3

    # b.each_set(index, len) == b.each_set[index, len], but faster.
    >> b.each_set(2,2) # Block is also allowed
    => [5,7]


    # The following methods modify a Bitset in place very quickly:
    >> a.intersect!(b)      #  like a &= b
    >> a.union!(b)          #  like a |= b
    >> a.difference!(b)     #  like a -= b
    >> a.xor!(b)            #  like a ^= b
    >> a.reset!             # Zeroes all bits

    # Above, "like" does not mean "identical to." a |= b creates a new
    # Bitset object. a.union!(b) changes an existing object which
    # affects all variables that point to the same object.

    # Attempting to apply bitwise binary operators or their in-place
    # equivalents between bitsets of different sizes will raise an
    # ArgumentError.

    >> b.to_binary_array
    => [0, 1, 0, 1, 0, 1, 0, 1]

    # b.dup and b.clone are also available.

    # Marshal.dump and Marshal.load are also supported. If you want to
    # save a few bytes and don't need Marshal.load to work, you can
    # use #pack and Bitset.unpack instead.

<a name="graph" />

## Graph

### Graph (undirected)
```ruby
g = Graph[1,2, 2,3, 2,4]
g.to_s
# => "(1=2)(2=3)(2=4)"
```

### Directed Graph
```ruby
dg = DirectedGraph[1,2 ,2,3 ,2,4, 4,5, 6,4, 1,6]
dg.to_s
# => "(1-2)(1-6)(2-3)(2-4)(4-5)(6-4)"
```

### Dijkstra's algorithm
```ruby
g = Containers::Graph[1,2, 1,3, 2,4, 4,5, 3,5]
weights = {[1,2] => 2, [2,4] => 1, [4,5] => 1, [1,3] => 1, [3,5] => 5}
g.dijkstra_shortest_paths(weights, 1)
# => {1=>[1], 2=>[1, 2], 3=>[1, 3], 4=>[1, 2, 4], 5=>[1, 2, 4, 5]} 
g.dijkstra_shortest_path(weights, 1, 5)
# => [1, 2, 4, 5]
```

### Bellman Ford's algorithm
```ruby
g = Containers::Graph[1,2, 1,3, 2,4, 4,5, 3,5]
weights = {[1,2] => 2, [2,4] => 1, [4,5] => 1, [1,3] => 1, [3,5] => 5}
g.bellman_ford_shortest_paths(weights, 1)
# => {1=>[1], 2=>[1, 2], 3=>[1, 3], 4=>[1, 2, 4], 5=>[1, 2, 4, 5]} 
```

### Topological sort
```ruby
g = Containers::Graph[1,2, 1,3, 2,4, 4,5, 3,5]
g.topsort_iterator.to_a
# => [1, 3, 2, 4, 5]
```

<a name="io-helpers" />

## IO Helpers

### Reader
Can read from `file` or `string`.
```ruby
Reader.file("a")
# => ["1,2,3", "4,5,6", "7,8,9"] 
Reader.file("a", col_sep: ",")
# => [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]] 
Reader.file("a", col_sep: ",", as: "i")
# => [[1, 2, 3], [4, 5, 6], [7, 8, 9]] 
Reader.file("a", col_sep: ",", mapper: ->(x) {x.to_i * x.to_i})
# => [[1, 4, 9], [16, 25, 36], [49, 64, 81]] 
Reader.string("0.1#0.2#0.3", line_sep: "#", as: 'r')
# => [(1/10), (1/5), (3/10)]  
```
Supported types for `as` are:
* `s` for string (default)
* `i` for integer
* `f` for float
* `r` for rational
* `c` for complex
* `sym` for symbol

### Writer
Can write to `file` or `string`.
```ruby
a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
Writer.string(a, line_sep: '@', col_sep: '.')
# => "1.2.3@4.5.6@7.8.9" 
Writer.string(a, line_sep: "\n", col_sep: ' ', mapper: ->(x) {"0,#{x}"})
# => "0,1 0,2 0,3\n0,4 0,5 0,6\n0,7 0,8 0,9" 
Writer.file("b", a, line_sep: "\n", col_sep: ' ', mapper: ->x {"0,#{x}"}) 
```

<a name="concurrent" />

## Concurrent Structures

They are included from [concurrent-ruby](https://github.com/ruby-concurrency/concurrent-ruby). To use them:
```ruby
Containers::Concurrent::Array
include Containers
Concurrent::Array
```
From [Concurrent Ruby Features](https://github.com/ruby-concurrency/concurrent-ruby#features--documentation):

### General-purpose Concurrency Abstractions

*   [Async](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Async.html):
    A mixin module that provides simple asynchronous behavior to a class. Loosely based on Erlang's 
    [gen_server](http://www.erlang.org/doc/man/gen_server.html).
*   [ScheduledTask](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/ScheduledTask.html):
    Like a Future scheduled for a specific future time.
*   [TimerTask](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/TimerTask.html):
    A Thread that periodically wakes up to perform work at regular intervals.
*   [Promises](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Promises.html):
    Unified implementation of futures and promises which combines features of previous `Future`,
    `Promise`, `IVar`, `Event`, `dataflow`, `Delay`, and (partially) `TimerTask` into a single 
    framework. It extensively uses the new synchronization layer to make all the features 
    **non-blocking** and **lock-free**, with the exception of obviously blocking operations like 
    `#wait`, `#value`. It also offers better performance.    

### Thread-safe Value Objects, Structures, and Collections

Collection classes that were originally part of the (deprecated) `thread_safe` gem:

*   [Array](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Array.html) A thread-safe
    subclass of Ruby's standard [Array](http://ruby-doc.org/core-2.2.0/Array.html).
*   [Hash](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Hash.html) A thread-safe
    subclass of Ruby's standard [Hash](http://ruby-doc.org/core-2.2.0/Hash.html).
*   [Set](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Set.html) A thread-safe
    subclass of Ruby's standard [Set](http://ruby-doc.org/stdlib-2.4.0/libdoc/set/rdoc/Set.html).
*   [Map](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Map.html) A hash-like object
    that should have much better performance characteristics, especially under high concurrency, 
    than `Concurrent::Hash`.
*   [Tuple](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Tuple.html) A fixed size
    array with volatile (synchronized, thread safe) getters/setters.

Value objects inspired by other languages:

*   [Maybe](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Maybe.html) A thread-safe,
    immutable object representing an optional value, based on 
    [Haskell Data.Maybe](https://hackage.haskell.org/package/base-4.2.0.1/docs/Data-Maybe.html).

Structure classes derived from Ruby's [Struct](http://ruby-doc.org/core-2.2.0/Struct.html):

*   [ImmutableStruct](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/ImmutableStruct.html)
    Immutable struct where values are set at construction and cannot be changed later.
*   [MutableStruct](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/MutableStruct.html)
    Synchronized, mutable struct where values can be safely changed at any time.
*   [SettableStruct](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/SettableStruct.html)
    Synchronized, write-once struct where values can be set at most once, either at construction 
    or any time thereafter.

Thread-safe variables:

*   [Agent](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Agent.html): A way to
    manage shared, mutable, *asynchronous*, independent state. Based on Clojure's 
    [Agent](http://clojure.org/agents).
*   [Atom](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Atom.html): A way to manage
    shared, mutable, *synchronous*, independent state. Based on Clojure's 
    [Atom](http://clojure.org/atoms).
*   [AtomicBoolean](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/AtomicBoolean.html)
    A boolean value that can be updated atomically.
*   [AtomicFixnum](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/AtomicFixnum.html)
    A numeric value that can be updated atomically.
*   [AtomicReference](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/AtomicReference.html)
    An object reference that may be updated atomically.
*   [Exchanger](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Exchanger.html)
    A synchronization point at which threads can pair and swap elements within pairs. Based on 
    Java's [Exchanger](http://docs.oracle.com/javase/7/docs/api/java/util/concurrent/Exchanger.html).
*   [MVar](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/MVar.html) A synchronized
    single element container. Based on Haskell's 
    [MVar](https://hackage.haskell.org/package/base-4.8.1.0/docs/Control-Concurrent-MVar.html) and 
    Scala's [MVar](http://docs.typelevel.org/api/scalaz/nightly/index.html#scalaz.concurrent.MVar$).
*   [ThreadLocalVar](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/ThreadLocalVar.html)
    A variable where the value is different for each thread.
*   [TVar](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/TVar.html) A transactional
    variable implementing software transactional memory (STM). Based on Clojure's 
    [Ref](http://clojure.org/refs).

### Java-inspired ThreadPools and Other Executors

*   See the [thread pool](http://ruby-concurrency.github.io/concurrent-ruby/master/file.thread_pools.html)
    overview, which also contains a list of other Executors available.

### Thread Synchronization Classes and Algorithms

*   [CountDownLatch](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/CountDownLatch.html)
    A synchronization object that allows one thread to wait on multiple other threads.
*   [CyclicBarrier](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/CyclicBarrier.html)
    A synchronization aid that allows a set of threads to all wait for each other to reach a common barrier point.
*   [Event](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Event.html) Old school
    kernel-style event.
*   [ReadWriteLock](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/ReadWriteLock.html)
    A lock that supports multiple readers but only one writer.
*   [ReentrantReadWriteLock](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/ReentrantReadWriteLock.html)
    A read/write lock with reentrant and upgrade features.
*   [Semaphore](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/Semaphore.html)
    A counting-based locking mechanism that uses permits.
*   [AtomicMarkableReference](http://ruby-concurrency.github.io/concurrent-ruby/master/Concurrent/AtomicMarkableReference.html)

# Other useful links

* https://github.com/kumar91gopi/Algorithms-and-Data-Structures-in-Ruby/
* https://github.com/sagivo/algorithms
* https://github.com/SciRuby/
