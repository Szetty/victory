require "test_helper"

class GreedyTest < Minitest::Test
  class TestSolution
    include Greedy::Solution
    attr_reader :data
    def initialize(data)
      @data = data
    end

    def score
      -@data.size
    end

    def next_solutions
      [
        TestSolution.new(@data),
        TestSolution.new(@data + [5]),
        TestSolution.new(@data[1..-1]),
      ]
    end
  end


  def test_greedy
    initial_solution = TestSolution.new([0, 1, 2, 3, 4])
    g = Greedy.init(initial_solution)
    g.run(1)
    assert_equal g.current_solution.data, [1, 2, 3, 4]
    g.run(2)
    assert_equal g.current_solution.data, [3, 4]
    assert_equal g.instance_variable_get(:@initial_solution), initial_solution
    history = g.instance_variable_get(:@solutions_history).map { |solution| solution.data }
    assert_equal history, [
      [0, 1, 2, 3, 4],
      [1, 2, 3, 4],
      [2, 3, 4],
      [3, 4]
    ]
  end

end