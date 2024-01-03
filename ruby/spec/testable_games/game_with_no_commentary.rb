require 'forwardable'
require 'no_game_commentator'
class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :puts,
                 :commentary,
                 :moved,
                 :answer_was_correct,
                 :question_answered_incorrectly,
                 :commentate_sent_to_penalty_box,
                 :gold_coin_awarded_to
  def initialize(commentary: UglyTrivia::NoGameCommentator.new)
    super()
    @commentary = commentary
  end
end
