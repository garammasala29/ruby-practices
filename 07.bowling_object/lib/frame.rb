# frozen_string_literal: true

class Frame
  def initialize(*scores)
    @scores = scores
  end

  def first_score
    @scores[0]
  end

  def second_score
    @scores[1]
  end

  def third_score
    @scores[2]
  end

  def score
    @scores.sum
  end

  def strike?
    first_score == 10 && third_score.nil?
  end

  def spare?
    !strike? && first_score + second_score == 10
  end
end
