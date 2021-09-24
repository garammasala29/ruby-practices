# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(input_scores)
    @input_scores = input_scores
  end

  def calc_score
    frames = scores_to_frames
    score = 0
    9.times do |number|
      score += frames[number].score + add_bonus(frames, number)
    end
    score + frames.last.score
  end

  private

  def scores_to_frames
    scores = parse_scores
    frames = []
    9.times do
      frames << if scores[0] == 10
                  Frame.new(*scores.shift(1))
                else
                  Frame.new(*scores.shift(2))
                end
    end
    frames << Frame.new(*scores)
    frames
  end

  def parse_scores
    scores = @input_scores.split(',')
    scores.map { |score| score == 'X' ? 10 : score.to_i }
  end

  def add_bonus(frames, number)
    if frames[number].strike? && frames[number + 1].strike?
      frames[number + 1].score + frames[number + 2].first_score
    elsif frames[number].strike?
      if number == 8
        frames[number + 1].first_score + frames[number + 1].second_score
      else
        frames[number + 1].score
      end
    elsif frames[number].spare?
      frames[number + 1].first_score
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
