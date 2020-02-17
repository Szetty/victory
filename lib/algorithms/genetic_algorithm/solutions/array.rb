class Algorithms::GeneticAlgorithm::ArraySolution
  include Algorithms::GeneticAlgorithm::Solution

  def initialize(array, possible_elements: [], mutate_change_rate: 0.5)
    @data, @possible_elements, @mutate_change_rate = array, possible_elements, mutate_change_rate
  end

  def mutate
    new_data = @data.map do |val|
      if rand < @mutate_change_rate
        (@possible_elements || @data).sample
      else
        val
      end
    end
    create_new_solution(new_data)
  end

  def crossover(other_solution)
    other_data = other_solution.data
    indices = rand(@data.size / 10).times.map { rand(@data.size) }.sort.<<(@data.size).each
    current_data = @data
    new_data = @data.map.with_index do |_element, idx|
      if idx == indices.peek
        current_data = current_data == @data ? other_data : @data
      end
      current_data[idx]
    end
    create_new_solution(new_data)
  end
end