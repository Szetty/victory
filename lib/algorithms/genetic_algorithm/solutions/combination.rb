class Algorithms::GeneticAlgorithm::CombinationSolution
  include Algorithms::GeneticAlgorithm::Solution

  def initialize(possible_elements, size, data: possible_elements.sample(size))
    @data, @possible_elements, @size = Set.new(data), possible_elements, size
  end

  def mutate
    create_new_solution(Set.new(@possible_elements.sample(@size)))
  end

  def crossover(other_solution)
    size = @data.size
    common = @data & other_solution.data
    sym_diff = @data ^ other_solution.data
    sampled_sym_diff = Set.new(sym_diff.to_a.sample(size - common.size))
    new_data = common.union(sampled_sym_diff)
    create_new_solution(new_data)
  end
end