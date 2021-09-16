# frozen_string_literal: true

require_relative './shot'
require_relative './frame'

class Game
  def initialize(input_scores)
    @input_scores = input_scores
    @shots = score_to_shots
    @frames = shots_to_frames
  end

  def score_to_shots
    scores = @input_scores.split(',')
    scores.map do |score|
      Shot.new(score).shot_score
    end
  end

  def shots_to_frames
    frames = @shots.first(9).map do
      @shots[0] == 10 ? @shots.shift(1) : @shots.shift(2)
    end
    frames << @shots
  end

  def calc_score
    score = 0
    @frames.each_with_index do |frame, index|
      @frame = Frame.new(*frame)

      next_frame = @frames[index + 1]
      @next_frame = Frame.new(*next_frame)

      after_next_frame = @frames[index + 2]
      @after_next_frame = Frame.new(*after_next_frame)

      score += @frame.frames_score + add_bonus
      score + @frames.last.sum if index == 8
    end
    score
  end

  def add_bonus
    if @frame.strike? && @next_frame.strike?
      [@next_frame.first_shot.shot_score, @next_frame.second_shot.shot_score].sum + @after_next_frame.first_shot.shot_score
    elsif @frame.strike?
      [@next_frame.first_shot.shot_score, @next_frame.second_shot.shot_score].sum
    elsif @frame.spare?
      @next_frame.first_shot.shot_score
    else
      0
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  input_scores = ARGV[0]
  game = Game.new(input_scores)
  puts game.calc_score
end
