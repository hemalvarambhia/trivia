require 'forwardable'
require 'string_io_based_game_commentator'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :puts,
                 :commentary,
                 :moved,
                 :commentate_answer_was_correct,
                 :commentate_question_incorrectly_answered,
                 :commentate_sent_to_penalty_box,
                 :commentate_gold_coins_won_by
  def initialize(commentary: UglyTrivia::StringIOBasedGameCommentator.new)
    super()
    @commentary = commentary
  end
end
