require "test_helper"

class SimulatedAnnealingTest < Minitest::Test
  include Algorithms::SimulatedAnnealing

  class TestSolution
    include Algorithms::SimulatedAnnealing::Solution

    def score
      x1, x2 = *@data
      0.2 + x1 * x1 + x2 * x2 - 0.1 * Math.cos(6 * Math::PI * x1) - 0.1 * Math.cos(6 * Math::PI * x2)
    end

    def next_solution
      x1, x2 = *@data
      new_x1 = (x1 + rand * 2 - 1) / 2
      new_x2 = (x2 + rand * 2 - 1) / 2
      new_data = T[new_x1, new_x2]
      TestSolution.new(new_data)
    end
  end

  def test_simulated_annealing
    solution = TestSolution.new(T[-1, -1])
    sim_annealing = Algorithms::SimulatedAnnealing.init(solution)
    sim_annealing.run(1000)
    best_solution = sim_annealing.best_solution
    assert best_solution.data[0] != -1
    assert best_solution.data[1] != -1
    assert best_solution.score < 2.0
  end
end