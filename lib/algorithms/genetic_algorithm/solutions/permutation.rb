class Algorithms::GeneticAlgorithm::PermutationSolution
  include Algorithms::GeneticAlgorithm::Solution

  def initialize(array)
    @data = array
  end

  def mutate
    create_new_solution(@data.shuffle)
  end

  def crossover(other_solution)
    sampled_indices = @data.each_index.to_a.sample(@data.size / 2)
    sampled_elements = sampled_indices.map { |i| @data[i] }
    elements_from_other = other_solution.data.select { |el| sampled_elements.include?(el) }
    new_data = @data.dup
    sampled_indices.zip(elements_from_other).each do |idx, el|
      new_data[idx] = el
    end
    create_new_solution(new_data)
  end
end