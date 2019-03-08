require "test_helper"

class MyTest < Minitest::Test
  def test_insert_find
    t = PrefixTree.new
    t.insert('hello')
    t << 'hello, sth'
    assert_equal true, t.find('hello')
    assert_equal true, t['hello, sth']
    t.insert('a', 1)
    assert_equal 1, t['a']
  end

  def test_count_partial
    t = PrefixTree.new
    t << 'hack'
    t << 'hackerrank'
    assert_equal 2, t.count_partial('hac')
    assert_equal 0, t.count_partial('hak')
  end
end