require 'forwardable'
require 'no_game_commentator'
class UglyTrivia::GameWithNoCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :commentary,
                 :gold_coin_awarded_to
  def initialize(commentary: UglyTrivia::NoGameCommentator.new)
    super
  end
end
