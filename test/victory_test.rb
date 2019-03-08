require "test_helper"

class VictoryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Victory::VERSION
  end
end
