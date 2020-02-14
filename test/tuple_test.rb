require 'test_helper'

class TupleTest < Minitest::Test
  def setup
    @is_tuple = -> x { assert_instance_of(Tuple, x) }
  end

  def test_creation
    t = T[1, 'a', [1, 2]]
    assert_equal 1, t[0]
    assert_equal 'a', t[1]
    assert_equal [1, 2], t[2]
  end

  def test_destructuring
    a, b, c = *T[1, 2, 3]
    assert_equal 1, a
    assert_equal 2, b
    assert_equal 3, c
  end

  def test_to_array
    t = T[1, 2, 3]
    assert_equal [1, 2, 3], t.to_a
  end

  def test_array_with_tuple_flatten
    a = [T[1, 2], T[3, 4]]
    assert_equal 2, a.size
    a = a.flatten
    assert_equal 2, a.size
    a.each(&@is_tuple)
  end
end