# frozen_string_literal: true

require 'minitest/autorun'
require './lib/game'

class BowlingTest < Minitest::Test
  def test_game1
    input_scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    game1 = Game.new(input_scores)
    assert_equal 139, game1.calc_score
  end

  def test_game2
    input_scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    game2 = Game.new(input_scores)
    assert_equal 164, game2.calc_score
  end

  def test_game3
    input_scores = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    game3 = Game.new(input_scores)
    assert_equal 107, game3.calc_score
  end

  def test_game4
    input_scores = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    game4 = Game.new(input_scores)
    assert_equal 134, game4.calc_score
  end

  def test_game
    input_scores = 'X,X,X,X,X,X,X,X,X,X,X,X'
    game5 = Game.new(input_scores)
    assert_equal 300, game5.calc_score
  end
end
