require "test_helper"

class ListTest < Minitest::Test

  def test_create
    l = L[1, 2, 3]
    assert_equal 1, l.pop
    assert_equal 2, l.pop
    assert_equal 3, l.pop
    assert_nil l.pop
  end

  def test_push_pop
    l = L.new
    l.push_back(4)
    assert_equal 4, l.peek_front
    assert_equal 4, l.peek_back
    l.push_front(3)
    assert_equal 3, l.peek_front
    assert_equal 4, l.peek_back
    l.push(9)
    assert_equal 3, l.peek_front
    assert_equal 9, l.peek_back
    assert_equal 3, l.pop_front
    assert_equal 9, l.pop
    assert_equal 4, l.pop_back
    assert_nil l.pop
    assert_nil l.pop_back
    assert_nil l.pop_front
  end
end