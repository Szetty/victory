Victory::Extension = Struct.new(:path, :name)
def extensions
  [
    Victory::Extension.new('algorithms/string', 'CString'),
    Victory::Extension.new('containers/bitset', 'CBitset'),
    Victory::Extension.new('containers/deque', 'CDeque'),
    Victory::Extension.new('containers/bst', 'CBst'),
    Victory::Extension.new('containers/rbtree_map', 'CRBTreeMap'),
    Victory::Extension.new('containers/splaytree_map', 'CSplayTreeMap'),
    Victory::Extension.new('containers/xor_list', 'CXORList'),
  ]
end

