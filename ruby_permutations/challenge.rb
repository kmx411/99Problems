gem 'minitest'
require 'minitest/autorun'

class Challenge
  # Part 0
  # A simple solution
  # -------------------
  
  def using_ruby n
    [*0..n].permutation.to_a
  end

  # Part 1
  # A recursive solution
  #
  # The function swaps a given index with all 
  # other items to the right
  # First index 0 is swaped with each value,
  # and for each of those index 1
  # is swapped, and so on.
  # ------------------------------------------

  def using_recursion n
    @recursive_permutations = []
    recursive_method (0..n).to_a unless n < 0

    return @recursive_permutations
  end

  def recursive_method n, k = 0
    length = n.length

    if length === k
      @recursive_permutations << n.clone
    end

    (k..length - 1).each do |i|
      n[k], n[i] = n[i], n[k]
      recursive_method n, k+1
      n[i], n[k] = n[k], n[i]
    end
  end

  # Part 2
  # An iterative solution
  #
  # The referred to problem:
  # stackoverflow.com/questions/2390954/
  # using the 'Quickperm countdown' Algorithm 
  # (because you already implemented the counting version)
  # -------------------------------------------------------

  def iteratively n
    n = n.floor
    results = []
    elements = (0..n).to_a
    control = (0..n+1).to_a
    i = 0

    while i < n+1 do
      control[i] = control[i] - 1
      j = i.odd? ? control[i] : 0
      elements[j], elements[i] = elements[i], elements[j]
      results << elements.clone
      i = 1
      while control[i] == 0 do
        control[i] = i
        i = i + 1
      end
    end

    return results
  end

  # Part 3
  # Given n, number of people and 
  # matrix preferences, where 
  # 0 = dont care, 1 = friends, -1 = not friends
  # find an optimal seating plan for the n people.
  #
  # Assumptions
  # --------------
  # the matrix entry for the same person is 0
  # preferences[i][i] = 0
  # the matrix entry for the same pair can be different.
  # person i likes j, but j dislikes i
  # preferences[i][j] = 1, preferences[j][i] = -1
  #
  # The optimal plan is that with the greatest weight,
  # weight = sum for all combinations of people to 
  # the left and to the right of each person.
  #
  # Solution Explained
  # -------------------
  # We create a weight function that can find a weight
  # of any given seating plan using the matrix.
  # The weight function takes the preferences of who is
  # sitting to the left and right of each person and sums
  # them.
  # We then take all permutations of 0..number of people
  # and we find the weight of each permutation. 
  # The permutation with the highest weight is the preferred
  # permutation, and that permutation is returned.
  # We also simplify the 0 and 1 and 2 cases
  # as they always reutrn the same
  # no matter what the matrix is.
  #
  # Run Time
  # ---------------------
  # If there are n seats then there are n! permutations
  # For each of those n permutations we generate (n-1)
  # weights to look up and sum. This results in
  # O((n-1)n!)
  # -----------------------------------------------------

  def calculate_preference combination
    a = combination[0]
    b = combination[1]
    @preferences[a][b] + @preferences[b][a]
  end

  def generate_combinations plan
    combinations = []

    (0..plan.length - 2).each do |i|
      combinations << [plan[i], plan[i+1]]
    end
    combinations << [plan.first, plan.last]
  end

  def weigh_plan plan
    weight = 0
    combinations = generate_combinations plan

    combinations.each do |combination|
      weight += calculate_preference(combination)
    end
    
    return weight
  end

  def find_optimal_plan n, preferences
    case n
    when 0
      return []
    when 1
      return [0]
    when 2
      return [0,1]
    end

    @preferences = preferences
    plans = using_ruby n-1
    best_weight = 0
    best_plan = plans.first

    plans.each do |plan|
      plan_weight = weigh_plan(plan)
      if plan_weight > best_weight
        best_weight = plan_weight
        best_plan = plan
      end
    end

    return best_plan
  end

end


class TestChallenge < MiniTest::Test
  def setup
    @challenge = Challenge.new
    @expected_size_0 = [[0]]
    @expected_size_2 = [
      [0,1,2],
      [0,2,1],
      [1,2,0],
      [1,0,2],
      [2,0,1],
      [2,1,0]
    ].sort
    @test_matrix = [[0,1,0,1],[1,0,1,-1],[0,-1,0,1],[-1,0,1,0]]
  end

  # Part 1 & 2 Tests
  # ---------------
  def test_empty
    recursive_result = @challenge.using_recursion 0
    iterative_result = @challenge.iteratively 0
    assert_equal recursive_result, @expected_size_0
    assert_equal iterative_result, @expected_size_0
  end

  def test_expected
    recursive_result = @challenge.using_recursion 2
    iterative_result = @challenge.iteratively 2
    assert_equal @expected_size_2, recursive_result.sort
    assert_equal @expected_size_2, iterative_result.sort
  end

  def test_only_positive
    # it should only accept integer values above 0
    # negative values should return empty
    
    recursive_result = @challenge.using_recursion(-5)
    iterative_result = @challenge.iteratively(-5)
    assert_equal [], recursive_result
    assert_equal [], iterative_result
  end

  def test_integers_only
    # non integer values like 2.8 will
    # only permute up to their floor, (0..2)
    # in the above case

    recursive_result = @challenge.using_recursion 2.8
    iterative_result = @challenge.iteratively 2.8
    assert_equal @expected_size_2, recursive_result.sort
    assert_equal @expected_size_2, iterative_result.sort
  end

   #Part 3 Tests
   #--------------

  def test_empty
    result = @challenge.find_optimal_plan 0, [[]]
    assert_equal result, []
  end

  def test_one_person
    result = @challenge.find_optimal_plan 1, [[0]]
    assert_equal result, [0]
  end

  def test_two_people
    result = @challenge.find_optimal_plan 2, [[0,1],[-1,0]]
    assert_equal result, [0,1]
  end

  def test_expected
    result = @challenge.find_optimal_plan 4, @test_matrix
    possible_results = [
      [0,1,2,3],
      [0,3,2,1],
      [1,0,3,2],
      [1,2,3,0],
      [2,1,0,3],
      [2,3,0,1],
      [3,0,1,2],
      [3,2,1,0]
    ]
    assert possible_results.include? result
  end

  def test_positive_overweighs_negative
    #people 2 and 1 want to sit together
    positive_matrix = [
      [0,1,-1,-1],
      [1,0,-1,-1],
      [-1,-1,0,-1],
      [-1,-1,-1,0]
    ]
    result = @challenge.find_optimal_plan 4, positive_matrix
    possible_results = [
      [0, 1, 2, 3],
      [0, 1, 3, 2],
      [0, 2, 3, 1],
      [0, 3, 2, 1],
      [1, 0, 2, 3],
      [1, 0, 3, 2],
      [1, 2, 3, 0],
      [1, 3, 2, 0],
      [2, 0, 1, 3],
      [2, 1, 0, 3],
      [2, 3, 0, 1],
      [2, 3, 1, 0],
      [3, 0, 1, 2],
      [3, 1, 0, 2],
      [3, 2, 0, 1],
      [3, 2, 1, 0]
    ]
    assert possible_results.include? result
  end
end
