require "test_helper"

class GeneticAlgorithmTest < Minitest::Test
  include Algorithms::GeneticAlgorithm

  class TestBitsetSolution < BitsetSolution; def score; @data.cardinality; end end


  def test_bitset_solution
    solution = TestBitsetSolution.new(Bitset.new(8), mutate_change_rate: 0.6)
    genetic_alg = Algorithms::GeneticAlgorithm.init([solution])
    population_test(genetic_alg)
    genetic_alg.run(10)
    assert_equal 8, genetic_alg.best_solution.score
  end

  class TestArraySolution < ArraySolution; def score; @data.sum; end end

  def test_list_solution
    solution = TestArraySolution.new(Array.new(50, 0), possible_elements: (0..50).to_a)
    genetic_alg = Algorithms::GeneticAlgorithm.init([solution])
    population_test(genetic_alg)
    genetic_alg.run(100, min_size: 100)
    assert genetic_alg.best_solution.score > 1000
  end

  class TestPermutationSolution < PermutationSolution; def score; @data[0]; end end

  def test_permutation_solution
    solution = TestPermutationSolution.new((0..50).to_a)
    genetic_alg = Algorithms::GeneticAlgorithm.init([solution])
    population_test(genetic_alg)
    genetic_alg.run(10)
    assert_equal 50, genetic_alg.best_solution.score
  end

  class TestCombinationSolution < CombinationSolution; def score; @data.sum; end end

  def test_combination_solution
    solution = TestCombinationSolution.new((0..50).to_a, 5)
    genetic_alg = Algorithms::GeneticAlgorithm.init([solution])
    population_test(genetic_alg)
    genetic_alg.run(20)
    assert genetic_alg.best_solution.score > 200
  end

  private

  def population_test(genetic_alg)
    genetic_alg.run(0)
    assert_equal genetic_alg.instance_variable_get(:@population).size, 128
    genetic_alg.run(10)
    assert_equal genetic_alg.instance_variable_get(:@population).size, 128
  end
end