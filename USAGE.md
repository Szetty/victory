# Usage

In this markdown you will see the usage of all the datastructures and algorithms available through the standard library and this gem.

# Data Structures

* [Array](#array)
* [Hash](#hash)
* [Set](#set)
* [Struct](#struct)
* [OpenStruct](#openstruct)
* [Tuple](#tuple)
* [Graph](#graph)
* [IOHelpers](#io-helpers)

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

<a name="set" />

## Set 

```ruby
require 'set'

s = Set.new
# => #<Set: {}> 
s << :a
# => #<Set: {:a}> 
s << :a
# => #<Set: {:a}> 
s << :b
# => #<Set: {:a, :b}> 
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
# NameError: no member 'nose' in struc
 

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

<a name="openstruct" />

## OpenStruct

```ruby
require 'ostruct'

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

For the following datastructures you will need to include `Containers` or prefix every container with it. 

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

# Other useful links

* https://github.com/kumar91gopi/Algorithms-and-Data-Structures-in-Ruby/
* https://github.com/sagivo/algorithms
* https://github.com/SciRuby/rb-gsl
