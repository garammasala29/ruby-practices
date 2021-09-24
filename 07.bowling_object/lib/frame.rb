# frozen_string_literal: true

class Frame
  attr_reader :first_score, :second_score, :third_score

  def initialize(*scores)
    @scores = scores
    @first_score = scores[0]
    @second_score = scores[1]
    @third_score = scores[2]
  end

  def score
    @scores.sum
  end

  def strike?
    @first_score == 10 && @third_score.nil?
  end

  def spare?
    !strike? && @first_score + @second_score == 10
  end
end
