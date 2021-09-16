# frozen_string_literal: true

require_relative './shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(*shots)
    @first_shot = Shot.new(shots[0])
    @second_shot = Shot.new(shots[1])
    @third_shot = Shot.new(shots[2])
  end

  def frames_score
    [@first_shot.shot_score, @second_shot.shot_score, @third_shot.shot_score].sum
  end

  def strike?
    @first_shot.shot_score == 10
  end

  def spare?
    !strike? && [@first_shot.shot_score, @second_shot.shot_score].sum == 10
  end
end
