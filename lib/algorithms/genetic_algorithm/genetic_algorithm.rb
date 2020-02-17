module Algorithms::GeneticAlgorithm
  module Solution
    abstract_method :mutate, :crossover, :score
    @data = nil
    attr_reader :data

    def valid?; true; end

    def create_new_solution(data)
      new_solution = self.clone
      new_solution.instance_variable_set(:@data, data)
      new_solution
    end
  end

  # population = list of solutions
  def self.init(population)
    Engine.new(population)
  end

  class Engine
    attr_reader :best_solution

    def initialize(population)
      @population = population
      @best_solution = population.max_by(&:score)
    end

    def run(iterations, min_size: 100, generate_retry: 10)
      @population = generate_until_minimum(@population, min_size)
      iterations.times do
        @population = @population.map do |solution|
          generate_new_solution(solution, @population, generate_retry)
        end
        @best_solution = (@population + [@best_solution]).max_by(&:score)
      end
    end

    private

    def generate_until_minimum(population, min_size)
      while population.size <= min_size
        new_solutions = []
        population.each_with_index do |solution, idx|
          if idx % 2 == 0
            new_solution = solution.mutate
            new_solutions << new_solution if new_solution.valid?
          else
            other_solution = population.reject.with_index { |_, i| i == idx }.sample
            new_solution = solution.crossover(other_solution)
            new_solutions << new_solution if new_solution.valid?
          end
        end
        population += new_solutions
      end
      population
    end

    def generate_new_solution(solution, population, generate_retry)
      generate_retry.times do
        new_solution = if rand < 0.5
                         solution.mutate
                       else
                         solution.crossover(population.sample)
                       end
        return new_solution if new_solution.valid?
      end
      solution
    end
  end
end