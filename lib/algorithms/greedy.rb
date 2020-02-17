module Algorithms::Greedy
  module Solution
    abstract_method  :score, :next_solutions
  end

  def self.init(solution)
    Engine.new(solution)
  end

  class Engine
    def initialize(solution)
      @initial_solution = solution
      @solutions_history = [@initial_solution]
    end

    def run(iterations)
      iterations.times do
        @solutions_history << @solutions_history[-1].next_solutions.max_by { |solution| solution.score }
      end
    end

    def best_solution
      @solutions_history[-1]
    end
  end
end
