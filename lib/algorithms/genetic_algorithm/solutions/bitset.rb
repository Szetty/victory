class Algorithms::GeneticAlgorithm::BitsetSolution
  include Algorithms::GeneticAlgorithm::Solution

  def initialize(bitset, mutate_change_rate: 0.5)
    @data, @mutate_change_rate = bitset, mutate_change_rate
  end

  def mutate
    new_data = @data.dup
    indices_to_change = []
    (0...@data.size).each do |idx|
      if rand < @mutate_change_rate
        indices_to_change << idx
      end
    end
    new_data.flip(indices_to_change)
    create_new_solution(new_data)
  end

  def crossover(other_solution)
    new_data = if rand < 0.5
                 @data ^ other_solution.data
               else
                 @data - other_solution.data
               end
    create_new_solution(new_data)
  end
end