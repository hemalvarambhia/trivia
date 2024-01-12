require 'forwardable'
require 'string_io_based_game_commentator'
class UglyTrivia::GameWithCommentary < UglyTrivia::Game
  extend Forwardable
  def_delegators :@commentary,
                 :commentary,
                 :gold_coin_awarded_to
  def initialize(commentary: UglyTrivia::StringIOBasedGameCommentator.new)
    super
  end
end
