require 'forwardable'
require 'string_io_based_game_commentator'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :puts,
                 :commentary,
                 :player_added,
                 :die_rolled,
                 :moved,
                 :answer_was_correct,
                 :question_answered_incorrectly,
                 :commentate_sent_to_penalty_box,
                 :gold_coin_awarded_to
  def initialize(commentary: UglyTrivia::StringIOBasedGameCommentator.new)
    super
  end
end
