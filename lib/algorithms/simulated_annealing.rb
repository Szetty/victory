module Algorithms::SimulatedAnnealing
  module Solution
    abstract_method  :score, :next_solution
    attr_reader :data

    def initialize(data)
      @data = data
    end
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
      iterations.times do |i|
        temperature = iterations.to_f / i.to_f
        current_solution = @solutions_history[-1]
        next_solution = current_solution.next_solution
        if acceptance_probability(current_solution.score, next_solution.score, temperature) > rand
          @solutions_history << next_solution
        end
      end
    end

    def best_solution; @solutions_history[-1] end

    private

    def acceptance_probability(current_score, next_score, temperature)
      if next_score > current_score
        return 1.0
      end
      Math.exp((next_score - current_score) / temperature)
    end
  end
end