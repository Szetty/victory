require "victory/version"

module Algorithms; end
module Containers; end

require 'algorithms/search'
require 'algorithms/sort'
require 'algorithms/string'
require 'algorithms/greedy'
require 'containers/prefix_tree'
require 'containers/heap'
require 'containers/stack'
require 'containers/deque'
require 'containers/queue'
require 'containers/priority_queue'
require 'containers/rb_tree_map'
require 'containers/splay_tree_map'
require 'containers/suffix_array'
require 'containers/trie'
require 'containers/kd_tree'
require 'containers/tuple'
require 'containers/list'
require 'containers/bitset'
require 'containers/xor_list'
require 'io_helpers/reader'
require 'io_helpers/writer'
require 'include_rgl'

require 'set'
Containers::Set = Set
require 'ostruct'
Containers::OpenStruct = OpenStruct
require 'matrix'
Containers::Matrix = Matrix
require 'concurrent-ruby'
Containers::Concurrent = Concurrent